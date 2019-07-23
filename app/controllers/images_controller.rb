class ImagesController < ApplicationController

  def destroy
    @image = Image.find params[:id]
    @tour = Tour.find params[:tour_id]

    if @tour.image_id == @image.id && @tour.images.length > 1
      puts @image.destroy
      puts "HERE1"
      puts @tour.inspect
      puts "len",@tour.images.length
      puts "id",@tour.images.first.id

      @tour.update_attribute(:image_id, @tour.images.first.id)
      puts "HERE2"
      puts @tour.inspect
    elsif @tour.images.length > 1
      @image.destroy
    end

    render json: Tour.main_image(@tour.image_id)
  end
end
