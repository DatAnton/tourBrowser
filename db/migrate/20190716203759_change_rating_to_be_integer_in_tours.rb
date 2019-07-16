class ChangeRatingToBeIntegerInTours < ActiveRecord::Migration[5.2]
  def change
    change_column :tours, :rating, :integer 
  end
end
