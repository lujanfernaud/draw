class PhotosController < ApplicationController
  before_action :check_query, only: :show

  def index
  end

  def show
    @request = Request.find_by(query: params[:id])

    if @request
      @request.update unless @request.updated_today?
    else
      @request = Request.create!(query: params[:id])
    end

    @photo = @request.photo
  end

  private

    def check_query
      redirect_to root_path unless valid_query?
    end

    def valid_query?
      Request.allowed_queries.include?(params[:id])
    end
end
