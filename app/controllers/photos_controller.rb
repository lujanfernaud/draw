class PhotosController < ApplicationController
  before_action :prepare_request

  def index
    @photos = @request.photos
  end

  def show
    @photo = @request.photos.find(params[:id])
  end

  private

    def prepare_request
      redirect_to root_path unless query_is_valid?
      prepare_query
      find_request
      update_request
    end

    def query_is_valid?
      Request.allowed_queries.include?(params[:request_id])
    end

    def prepare_query
      @query = Request.allowed_queries[params[:request_id]]
    end

    def find_request
      @request = Request.find_by(query: @query)
    end

    def update_request
      @request&.update_photos unless @request&.updated_today?
    end
end
