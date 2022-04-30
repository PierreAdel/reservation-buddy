module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :authenticate_admin, only: [:get_all_reservations]
      before_action :authenticate_user, only: %i[get_all_my_reservations create]

      def get_all_reservations
        reservations =
          Reservation.all.limit(limit).offset(offset).order("#{sort} DESC")

        render json: {
                 pages: (Reservation.all.length.to_f / limit).ceil(0),
                 page: params.fetch(:page, 1).to_i,
                 data: ReservationsRepresenter.new(reservations).as_json,
               }
      end

      def get_all_my_reservations
        reservations =
          Reservation.all.where("customer_id = #{helpers.current_user.id}")
        render json: ReservationsRepresenter.new(reservations).as_json
      end

      def create
        hotel = Hotel.find_by(slug: params[:slug])
        if hotel.nil?
          render json: { errors: 'Hotel not found' }, status: :not_found and
            return
        end

        reservation =
          Reservation.new(
            customer_id: helpers.current_user.id,
            hotel_id: hotel.id,
            date_from: params[:date_from],
            number_of_days: params[:number_of_days],
          )

        if reservation.save
          render json: ReservationRepresenter.new(reservation).as_json,
                 status: :created
        else
          render json: {
                   errors: reservation.errors.full_messages,
                 },
                 status: :unprocessable_entity
        end
      end

      private

      def reservation_params
        params.require(:reservation).permit(:slug)
      end
    end
  end
end
