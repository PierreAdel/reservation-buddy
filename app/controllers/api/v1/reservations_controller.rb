module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :authenticate_admin, only: [:get_all_reservations]
      before_action :authenticate_user, only: %i[get_all_my_reservations create]
      MAX_PAGINATION_LIMIT = 100

      def get_all_reservations
        reservations =
          Reservation.all.limit(limit).offset(offset).order(sort, :desc)

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
          render json: { errors: 'Hotel not found' }, status: 404 and return
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
          render json: { errors: reservation.errors.full_messages }, status: 422
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

      def reservation_params
        params.require(:reservation).permit(:slug)
      end

      def authenticate_admin
        unless helpers.admin_logged_in?
          render json: { errors: 'Admin not Authorized' }, status: :unauthorized
        end
      end

      def authenticate_user
        unless helpers.user_logged_in?
          render json: {
                   errors: 'User not Authorized',
                   data: [],
                 },
                 status: :unauthorized
        end
      end

      # def create
      #     Stripe.api_key = ENV["STRIPE_SECRET_KEY"]

      #     order = Order.find(params[:orderId])
      #     amount = order.shoes.sum(:cost) * 100

      #     charge = Stripe::Charge.create(

      #         :amount => amount,
      #         :desc => "OG store",
      #         :currency => "usd",
      #         :source => params[:token]
      #     )

      # rescue Stripe::CardError => e
      #     render json: {error:"erer"}, status: 500
      # end
      # end

      def update; end

      def destroy; end
    end
  end
end
