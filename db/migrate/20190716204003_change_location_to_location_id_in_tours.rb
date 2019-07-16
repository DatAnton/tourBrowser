class ChangeLocationToLocationIdInTours < ActiveRecord::Migration[5.2]
  def change
    rename_column :tours, :location, :location_id
  end
end
