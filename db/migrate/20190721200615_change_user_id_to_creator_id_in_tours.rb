class ChangeUserIdToCreatorIdInTours < ActiveRecord::Migration[5.2]
  def change
    rename_column :tours, :user_id, :creator_id
  end
end
