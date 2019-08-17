class ImagesController < ApplicationController

  def destroy
    @image = Image.find params[:id]
    @tour = Tour.find params[:tour_id]

    if @tour.image_id == @image.id && @tour.images.length > 1
      @image.destroy

      @tour.update_attribute(:image_id, @tour.images.first.id)

    elsif @tour.images.length > 1
      @image.destroy
    end

    render json: Tour.main_image(@tour.image_id)
  end

  def show
    @image = Image.find params[:id]
    render json: @image.image
  end
end
