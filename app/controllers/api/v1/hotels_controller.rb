module Api
    module V1
    class HotelsController < ApplicationController
        protect_from_forgery with: :null_session
        before_action :authenticate_user, only: [:show]

        def index
            hotels = Hotel.all
            render json: HotelSerializer.new(hotels).serialized_json
        end

        def show
            hotel = Hotel.find_by(slug: params[:slug])
            # render json: HotelSerializer.new(hotel, options).serialized_json
            render json: HotelSerializer.new(hotel).serialized_json
        end

        def create
            hotel = Hotel.new(hotel_params)
            if hotel.save
                render json: HotelSerializer.new(hotel).serialized_json
            else
                render json: { errors: hotel.errors.full_messages }, status: 422
            end
        end

        def update
            hotel = Hotel.find_by(slug: params[:slug])
            if hotel.update(hotel_params)
                # render json: HotelSerializer.new(hotel, options).serialized_json
                render json: HotelSerializer.new(hotel).serialized_json
            else
                render json: { errors: hotel.errors.full_messages }, status: 422
            end
        end

        def destroy
            hotel = Hotel.find_by(slug: params[:slug])
            if hotel.destroy
                head :no_content
            else
                render json: { errors: hotel.errors.full_messages }, status: 422
            end
        end

        private
        def hotel_params
            params.require(:hotel).permit(:name, :cover_image_url)
        end

        def authenticate_user
            unless helpers.logged_in?
              render json: { errors: "Not Authorized" }, status: :unauthorized
            end
          end

        # def options 
        #     @options ||= {include: %i[admins]}
        # end
    end
    end
end