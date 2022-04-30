class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  MAX_PAGINATION_LIMIT = 100

  protected

  def limit
    [params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i, MAX_PAGINATION_LIMIT].min
  end

  def offset
    params.fetch(:page, 1).to_i * limit.to_i - limit.to_i
  end

  def sort
    params.fetch(:sort, 'created_at')
  end

  def authenticate_admin
    unless helpers.admin_logged_in?
      render json: { errors: 'Admin not Authorized' }, status: :unauthorized
    end
  end

  def authenticate_user
    unless helpers.user_logged_in?
      render json: {
               errors: 'User not Authorized',
               data: [],
             },
             status: :unauthorized
    end
  end
end
