class HotelsController < ApplicationController

  def new
    @hotel = Hotel.new
  end

  def hotels_of_user
    @hotels = current_user.hotels
  end

  def index
    @hotels = Hotel.where(free: true)

    if params[:location_id] && params[:location_id] != '0'
      @location = Location.find params[:location_id]
      @hotels = @hotels.where(location_id: @location.id)
    end
    @hotels = @hotels.paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html
      format.json { render json: @hotels }
    end
  end

  def update
    @hotel = Hotel.find params[:id]
    @hotel.update_attribute(:free, params[:free])
    render json: @hotel
  end

  def show
    @hotel = Hotel.find params[:id]
  end

  def destroy
    @hotel = Hotel.find params[:id]
    @hotel.destroy
    redirect_to root_path
  end

  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user_id = current_user.id

    if @hotel.save
      @main_image = ImageHotel.new(image: params[:main_image], hotel_id: @hotel.id)
      @main_image.save
      @hotel.update_attribute(:image_id, @main_image.id)

      @images = params[:images]
      @images.each do |img|
        ImageHotel.create(image: img, hotel_id: @hotel.id)
      end
      render json: @hotel
    else
      render json: { errors: @hotel.errors.full_messages }
    end

  end

  private

  def hotel_params
    params.require(:hotel).permit(:name, :description, :location_id, :contacts, :address, :free)
  end

end
