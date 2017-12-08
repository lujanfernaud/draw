class RandomPhotosController < ApplicationController
  before_action :prepare_request

  def show
    @photo = @request.photos.sample
    redirect_to request_photo_path(@request.name, @photo.id)
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
