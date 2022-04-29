module Api
  module V1
    class CustomersController < ApplicationController
      # before_action :authenticate_admin, only: %i[index show destroy]

      def index
        customers = Customer.all
        render json: { data: CustomersRepresenter.new(customers).as_json }
      end

      def show
        render json: { errors: 'asd not found' }, status: :not_found
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
