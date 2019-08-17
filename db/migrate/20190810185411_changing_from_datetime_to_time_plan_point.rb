class ChangingFromDatetimeToTimePlanPoint < ActiveRecord::Migration[5.2]
  def change
    change_column :plan_points, :to_date, :time
    change_column :plan_points, :from_date, :time
  end
end
