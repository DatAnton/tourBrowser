class ToursController < ApplicationController
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
    if @tour.save
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
    params.require(:tour).permit(:name, :description, :location_id, :main_image)
  end
end
