module Api
    module V1
    class RegistrationsController < ApplicationController
        
       
        def create
            @user = Customer.new(name: params[:name], email: params[ :email], password: params[:password], password_confirmation: params[:password])
            p @user
            if @user.save
                session[:user_id] = @user.id 
                render json: {
                    status: :created,
                    logged_in: true,
                    user: @user
                }
            else
                render json: { status: 500 }
            end
        end
        end
    end
end