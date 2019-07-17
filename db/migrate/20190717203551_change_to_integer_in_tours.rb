class ChangeToIntegerInTours < ActiveRecord::Migration[5.2]
  def change
    change_column :tours, :image_id, :integer
  end
end
