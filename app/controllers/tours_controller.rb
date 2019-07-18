class ToursController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @tour = Tour.new
    @regions = Tour.get_regions
  end

  def show
    @tour = Tour.find(params[:id])
  end

  def get_regions
    @regions = Tour.get_regions
    render json: @regions
  end

  def get_locations_by_region
    @region = params[:region]
    @locations = Location.all.where(region: @region)
    render json: @locations
  end

  def create
    @tour = Tour.new(tour_params)
    @user = current_user
    puts ">>>>"
    puts @user
    @tour.user_id = current_user.id

    if @tour.save
      @images = params[:images]
      @images.each do |img|
        im = Image.new(image: img, tour_id: @tour.id)
        im.save
      end
      @main_image = Image.new(image: params[:main_image], tour_id: @tour.id)
      @main_image.save
      @tour.update_attribute(:image_id, @main_image.id)

      render json: @tour
    else
      render json: { errors: @tour.errors.full_messages }
    end
  end


  def index
    @tours = Tour.all
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :description, :location_id, :is_private)
  end
end
