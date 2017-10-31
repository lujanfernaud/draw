class PhotosController < ApplicationController
  before_action :check_reference, only: :show

  def index
  end

  def show
    @request = Request.find_by(reference: params[:id])

    if @request
      @request.update unless @request.updated_today?
    else
      @request = Request.create!(reference: params[:id])
    end

    @photo = @request.photo
  end

  private

    def check_reference
      redirect_to root_path unless valid_reference?
    end

    def valid_reference?
      Request.allowed_references.include?(params[:id])
    end
end
