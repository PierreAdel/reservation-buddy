module Api
  module V1
    class CustomersController < ApplicationController
      # protect_from_forgery with: :null_session
      before_action :authenticate_admin, only: %i[index show destroy]

      # before_action :authenticate_user, only: [:update]

      MAX_PAGINATION_LIMIT = 100

      def index
        # binding.irb
        customers =
          Customer
            .all
            .limit(limit)
            .offset(offset)
            .order(sort, :desc)
            .where("name LIKE '%#{params.fetch(:search, '')}%'")

        render json: {
                 pages: (Customer.all.length.to_f / limit).ceil(0),
                 page: params.fetch(:page, 1).to_i,
                 data: CustomersRepresenter.new(customers).as_json,
               }
      end

      def show
        customer = Customer.find_by(email: params[:email] + +'.com')
        if customer
          render json: CustomerRepresenter.new(customer).as_json
        else
          render json: { errors: 'Not found' }, status: 404
        end
      end

      # def update
      #     customer = Customer.find_by(email: params[:email]++".com")
      #     if !customer
      #         render json: { errors: "Customer not found" }, status: 404
      #     elsif customer.update(customer_params)
      #         render json: customer
      #     else
      #         render json: { errors: customer.errors.full_messages }, status: 422
      #     end
      # end

      def destroy
        customer = Customer.find_by(email: params[:email] + +'.com')
        if customer.nil?
          render json: { errors: 'Customer not found' }, status: 404
        elsif customer.destroy
          head :no_content
        else
          render json: { errors: customer.errors.full_messages }, status: 422
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

      def customer_params
        params.require(:customer).permit(:name, :email, :password)
      end

      def authenticate_admin
        unless helpers.admin_logged_in?
          render json: { errors: 'Admin not Authorized' }, status: :unauthorized
        end
      end

      def authenticate_user
        unless helpers.user_logged_in?
          render json: { errors: 'User not Authorized' }, status: :unauthorized
        end
      end
      # def options
      #     @options ||= {include: %i[admins]}
      # end
    end
  end
end
