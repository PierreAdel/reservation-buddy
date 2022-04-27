module CurrentAdminConcern
  extend ActiveSupport::Concern

  included { before_action :set_current_admin }

  def set_current_admin
    @current_admin = Admin.find(session[:admin_id]) if session[:admin_id]
  end
end
