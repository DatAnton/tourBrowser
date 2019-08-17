class TourSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :location, :image
  def image
    {
      picture: Tour.main_image(self.object.image_id).image
    }
  end
end
