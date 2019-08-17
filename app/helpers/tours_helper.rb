module ToursHelper
  def make_gallery(images, main_image_id)
    images.select { |img| img.id != main_image_id }
  end

  def creator_exists(creator_id)
    # creator_id != 0 ? User.where(id: creator_id).first : nil
    User.where(id: creator_id).first
  end
end
