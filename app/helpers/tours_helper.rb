module ToursHelper
  def make_gallery(images, main_image_id)
    images.select { |img| img.id != main_image_id }
  end
end
