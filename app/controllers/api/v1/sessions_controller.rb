module Api
  module V1
    class SessionsController < ApplicationController
      include CurrentUserConcern
      include CurrentAdminConcern

      def user_login
        @user = Customer.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          render json: {
                   logged_in: true,
                   user: CustomerRepresenter.new(@user).as_json,
                 },
                 status: :created
        else
          render json: {}, status: 401
        end
      end

      def admin_login
        @admin = Admin.find_by(email: params[:email])
        if @admin && @admin.authenticate(params[:password])
          session[:admin_id] = @admin.id
          render json: {
                   logged_in: true,
                   admin: AdminRepresenter.new(@admin).as_json,
                 },
                 status: :created
        else
          render json: {}, status: 401
        end
      end

      def user_logged_in
        if @current_user
          render json: {
                   logged_in: true,
                   user: CustomerRepresenter.new(@current_user).as_json,
                 },
                 status: :ok
        else
          render json: { logged_in: false }, status: :ok
        end
      end

      def admin_logged_in
        if @current_admin
          render json: {
                   logged_in: true,
                   admin: AdminRepresenter.new(@current_admin).as_json,
                 },
                 status: :ok
        else
          render json: { logged_in: false }, status: :ok
        end
      end

      def user_logout
        reset_session
        render json: { logged_out: true }, status: :ok
      end

      def admin_logout
        reset_session
        render json: { logged_out: true }, status: :ok
      end
    end
  end
end
