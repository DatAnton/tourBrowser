class AddingPrivateAttributeToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :is_private, :boolean, default: false
  end
end
