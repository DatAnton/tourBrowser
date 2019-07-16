class ChangeLocationToBeIntegerInTours < ActiveRecord::Migration[5.2]
  def change
    change_column :tours, :location, :integer 
  end
end
