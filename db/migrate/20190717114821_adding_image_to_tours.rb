class AddingImageToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :main_image, :string
  end
end
