class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  MAX_PAGINATION_LIMIT = 100
end
