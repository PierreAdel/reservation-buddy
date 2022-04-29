module Api
  module V1
    class HotelsController < ApplicationController
      def index
        render json: { pages: 'hello' }
      end
    end
  end
end
