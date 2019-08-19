class AddingFieldsToHotels < ActiveRecord::Migration[5.2]
  def change
    add_column :hotels, :contacts, :string
    add_column :hotels, :address, :string
    add_column :hotels, :location_id, :integer
    add_column :hotels, :free, :boolean
    rename_column :hotels, :image, :image_id
  end
end
