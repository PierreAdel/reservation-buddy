module Api
  module V1
    class HotelsController < ApplicationController
      # protect_from_forgery with: :null_session
      before_action :authenticate_admin, only: %i[create update destroy]
      MAX_PAGINATION_LIMIT = 100
      def index
        hotels =
          Hotel
            .all
            .limit(limit)
            .offset(offset)
            .order(sort, :desc)
            .where(
              "city LIKE '%#{params.fetch(:search, '')}%' OR hotel_name LIKE '%#{params.fetch(:search, '')}%'",
            )

        render json: {
                 pages: (Hotel.all.length.to_f / limit).ceil(0),
                 page: params.fetch(:page, 1).to_i,
                 data: HotelsRepresenter.new(hotels).as_json,
               }
      end

      def show
        hotel = Hotel.find_by(slug: params[:slug])
        render json: HotelRepresenter.new(hotel).as_json

        # admin = Admin.find(hotel.admin_id)
        # render json: admin

        # hotel =  Hotel
        # .select('hotels.*, admins.name as admin_name')
        # .joins("INNER JOIN admins ON admins.id = hotels.admin_id")
        # render json: hotel
      end

      def create
        hotel =
          Hotel.new(hotel_params.merge(admin_id: helpers.current_admin.id))
        if hotel.save
          render json: HotelRepresenter.new(hotel).as_json, status: :created
        else
          render json: { errors: hotel.errors.full_messages }, status: 422
        end
      end

      def update
        hotel = Hotel.find_by(slug: params[:slug])
        if hotel.nil?
          render json: { errors: 'Hotel not found' }, status: 404
        elsif hotel.update(hotel_params)
          # render json: HotelSerializer.new(hotel, options).serialized_json
          render json: hotel
        else
          render json: { errors: hotel.errors.full_messages }, status: 422
        end
      end

      def destroy
        hotel = Hotel.find_by(slug: params[:slug])
        if hotel.nil?
          render json: { errors: 'Hotel not found' }, status: 404
        elsif hotel.destroy
          head :no_content
        else
          render json: { errors: hotel.errors.full_messages }, status: 422
        end
      end

      private

      def limit
        [
          params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
          MAX_PAGINATION_LIMIT,
        ].min
      end

      def offset
        params.fetch(:page, 1).to_i * limit.to_i - limit.to_i
      end

      def sort
        params.fetch(:sort, 'created_at')
      end

      def hotel_params
        params
          .require(:hotel)
          .permit(
            :hotel_name,
            :cover_image_url,
            :description,
            :city,
            :score,
            :price_per_night,
          )
      end

      def authenticate_admin
        unless helpers.admin_logged_in?
          render json: { errors: 'Not Authorized' }, status: :unauthorized
        end
      end

      # def options
      #     @options ||= {include: %i[admins]}
      # end
    end
  end
end
