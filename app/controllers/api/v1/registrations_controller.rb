module Api
  module V1
    class RegistrationsController < ApplicationController
      def create
        @user =
          Customer.new(
            name: params[:name],
            email: params[:email],
            password: params[:password],
            password_confirmation: params[:password],
          )
        if @user.save
          session[:user_id] = @user.id
          render json: {
                   logged_in: true,
                   user: CustomerRepresenter.new(@user).as_json,
                 },
                 status: :created
        else
          render json: {
                   errors: @user.errors.full_messages,
                 },
                 status: :internal_server_error
        end
      end
    end
  end
end
