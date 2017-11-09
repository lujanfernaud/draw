class PhotosController < ApplicationController
  before_action :check_query, :prepare_query, only: :show

  def index
  end

  def show
    @request = Request.find_by(query: @query)

    if @request
      @request.update_photos unless @request.updated_today?
    else
      @request = Request.create!(query: @query)
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

    def prepare_query
      @query = Request.allowed_queries[params[:id]]
    end
end
