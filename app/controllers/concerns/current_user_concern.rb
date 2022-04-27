module CurrentUserConcern
  extend ActiveSupport::Concern

  included { before_action :set_current_user }

  def set_current_user
    @current_user = Customer.find(session[:user_id]) if session[:user_id]
  end
end
