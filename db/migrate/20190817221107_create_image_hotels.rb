class CreateImageHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :image_hotels do |t|
      t.integer :hotel_id
      t.string :image
      t.timestamps
    end
  end
end
