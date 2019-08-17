class AddingAdminAndCountsOfHotelsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :count_of_hotels, :integer, default: 0
  end
end
