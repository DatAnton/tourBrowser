class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :name
      t.string :description
      t.string :location
      t.string :rating

      t.timestamps
    end
  end
end
