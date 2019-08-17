class AddingDayDateToPlanPoint < ActiveRecord::Migration[5.2]
  def change
    add_column :plan_points, :day_date, :datetime
  end
end
