class RenameColumnsInPlanPoints < ActiveRecord::Migration[5.2]
  def change
    rename_column :plan_points, :from_date, :from_time
    rename_column :plan_points, :to_date, :to_time
  end
end
