class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  MAX_PAGINATION_LIMIT = 100

  protected

  def limit
    [
      [
        params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i,
        MAX_PAGINATION_LIMIT,
      ].min,
      1,
    ].max
  end

  def page
    [params.fetch(:page, 1).to_i, 1].max
  end

  def offset
    page * limit.to_i - limit.to_i
  end

  def sort(sort_array)
    if sort_array.include? params.fetch(:sort, 'created_at')
      params.fetch(:sort, 'created_at')
    else
      'created_at'
    end
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
