class PhotosController < ApplicationController
  before_action :prepare_request

  def index
    @photos_decorators = @request.photos.map do |photo|
      PhotoDecorator.new(photo)
    end
  end

  def show
    photo = @request.photos.find(params[:id])
    @photo_decorator = PhotoDecorator.new(photo)
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
