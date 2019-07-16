class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :region
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
