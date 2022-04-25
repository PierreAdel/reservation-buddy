module SessionsHelper
  
    def current_user
      @user ||= Customer.find_by(id: session[:user_id]) if session[:user_id]
    end
  
    def user_logged_in?
      !current_user.nil?
    end

    def current_admin
      @admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id]
    end
  
    def admin_logged_in?
      !current_admin.nil?
    end
  
  end