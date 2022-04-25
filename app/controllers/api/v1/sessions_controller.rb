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
                    status: :created,
                    logged_in: true,
                    user: @user
                }
            else
                render json: { status: 401 }
            end
        end

        def admin_login
            @admin = Admin.find_by(email: params[:email])
            if @admin && @admin.authenticate(params[:password])
                session[:admin_id] = @admin.id
                render json: {
                    status: :created,
                    logged_in: true,
                    admin: @admin
                }
            else
                render json: { status: 401 }
            end
        end



        def user_logged_in
            if @current_user
                render json: {
                    logged_in: true,
                    user: @current_user
                }
            else
                render json: {
                    logged_in: false
                }
            end
        end

        def admin_logged_in
            if @current_admin
                render json: {
                    logged_in: true,
                    admin: @current_admin
                }
            else
                render json: {
                    logged_in: false
                }
            end
        end

        def user_logout
            reset_session
            render json: { status: 200, logged_out: true }
        end

        def admin_logout
            reset_session
            render json: { status: 200, logged_out: true }
        end
    end
end
end