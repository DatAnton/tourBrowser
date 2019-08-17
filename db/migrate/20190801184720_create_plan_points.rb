class CreatePlanPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :plan_points do |t|
      t.integer :plan_id
      t.integer :tour_id
      t.datetime :from_date
      t.datetime :to_date
      
      t.timestamps
    end
  end
end
