module Api
  module V1
    class HotelsController < ApplicationController
      # before_action :authenticate_admin, only: %i[create update destroy]
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
      end

      def create
        hotel =
          Hotel.new(hotel_params.merge(admin_id: helpers.current_admin.id))
        if hotel.save
          render json: HotelRepresenter.new(hotel).as_json, status: :created
        else
          render json: {
                   errors: hotel.errors.full_messages,
                 },
                 status: :unprocessable_entity
        end
      end

      def update
        hotel = Hotel.find_by(slug: params[:slug])
        if hotel.nil?
          render json: { errors: 'Hotel not found' }, status: :not_found
        elsif hotel.update(hotel_params)
          render json: hotel
        else
          render json: {
                   errors: hotel.errors.full_messages,
                 },
                 status: :unprocessable_entity
        end
      end

      def destroy
        hotel = Hotel.find_by(slug: params[:slug])
        if hotel.nil?
          render json: { errors: 'Hotel not found' }, status: :not_found
        elsif hotel.destroy
          head :no_content
        else
          render json: {
                   errors: hotel.errors.full_messages,
                 },
                 status: :unprocessable_entity
        end
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
    end
  end
end
