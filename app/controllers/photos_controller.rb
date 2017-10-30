class PhotosController < ApplicationController
  before_action :save_reference, :check_reference, only: :show

  REFERENCES = [
    "female",
    "male",
    "face",
    "animal",
    "flower",
    "house",
    "object",
    "landscape"
  ].freeze

  def index
  end

  def show
    @request = Request.find_by(reference: @reference)

    if @request
      @request.update unless @request.updated_today?
    else
      @request = Request.create!(reference: @reference)
    end

    @photo = @request.photo
  end

  private

    def save_reference
      @reference = params[:id]
    end

    def check_reference
      redirect_to root_path unless valid_reference?
    end

    def valid_reference?
      REFERENCES.include?(@reference)
    end
end
