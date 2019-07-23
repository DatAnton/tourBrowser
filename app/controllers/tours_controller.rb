require 'uri'
require 'net/http'
require 'json'

class ToursController < ApplicationController
  def new
    @tour = Tour.new
    @regions = Tour.get_regions
  end

  def show
    @tour = Tour.find(params[:id])
    uri = URI('http://api.geonames.org/findNearByWeatherJSON')
    params = { lat: 50, lng: 30, username: 'datanton' }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    @weather = JSON.parse(res.body)['weatherObservation']
  end

  def edit
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

  def destroy
    @tour = Tour.find params[:id]
    @tour.destroy
    redirect_to tours_path
  end

  def create
    @tour = Tour.new(tour_params)
    @user = current_user

    @tour.creator_id = current_user.id

    if @tour.save
      ToursAndUser.create(tour_id: @tour.id, user_id: current_user.id)

      @main_image = Image.new(image: params[:main_image], tour_id: @tour.id)
      @main_image.save
      @tour.update_attribute(:image_id, @main_image.id)


      @images = params[:images]
      @images.each do |img|
        Image.create(image: img, tour_id: @tour.id)
      end
      render json: @tour
    else
      render json: { errors: @tour.errors.full_messages }
    end
  end

  def update
    @tour = Tour.find params[:id]
    if @tour.update_attributes(tour_params)
      @main_image = params[:main_image]
      if @main_image[:id] == 0
        Tour.main_image(@tour.image_id).destroy
        @tour.update_attribute(:image_id, (Image.create(image: @main_image[:image], tour_id: @tour.id)).id)
      end

      @images = params[:images]
      @images.each do |img|
        if img[:id] == 0
          Image.create(image: img[:image], tour_id: @tour.id)
        end
      end
      render json: @tour
    else
      render json: { errors: @tour.errors.full_messages }
    end
  end

  def index
    @tours = Tour.all.where(is_private: false)
  end

  private

  def tour_params
    params.require(:tour).permit(:name, :description, :location_id, :is_private)
  end

  def sending_weather_query(lat, lng)
    uri = URI('http://api.geonames.org/findNearByWeatherJSON')
    params = { lat: 50, lng: 30, username: 'datanton' }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
  end
end
