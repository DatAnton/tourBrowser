class ChangeMainImageToImageIdInTours < ActiveRecord::Migration[5.2]
  def change
    rename_column :tours, :main_image, :image_id
  end
end
