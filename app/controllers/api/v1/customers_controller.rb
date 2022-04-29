module Api
  module V1
    class CustomersController < ApplicationController
      before_action :authenticate_admin, only: %i[index show destroy]

      def index
        customers =
          Customer
            .all
            # .limit(limit)
            .offset(offset)
            .order(sort, :desc)
            .where("name LIKE '%#{params.fetch(:search, '')}%'")

        render json: {
                 #  pages: (Customer.all.length.to_f / limit).ceil(0),
                 page: params.fetch(:page, 1).to_i,
                 data: CustomersRepresenter.new(customers).as_json,
               }
      end

      def show
        customer = Customer.find_by(email: params[:email] + +'.com')
        if customer
          render json: CustomerRepresenter.new(customer).as_json
        else
          render json: { errors: 'Customer not found' }, status: :not_found
        end
      end

      def destroy
        customer = Customer.find_by(email: params[:email] + +'.com')
        if customer.nil?
          render json: { errors: 'Customer not found' }, status: :not_found
        elsif customer.destroy
          head :no_content
        else
          render json: {
                   errors: customer.errors.full_messages,
                 },
                 status: :unprocessable_entity
        end
      end

      private

      def customer_params
        params.require(:customer).permit(:name, :email, :password)
      end
    end
  end
end
