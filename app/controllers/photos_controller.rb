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
      find_request
      update_request
    end

    def query_is_valid?
      Request.allowed_queries.include?(params[:request_id])
    end

    def find_request
      @request = Request.find_by(name: params[:request_id])
    end

    def update_request
      @request&.update_photos unless @request&.updated_today?
    end
end
