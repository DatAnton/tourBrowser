class PlanPointsController < ApplicationController
  def new
    @plan_point = PlanPoint.new
    @plan = Plan.find params[:plan_id]
  end

  def create
    @plan_point = PlanPoint.new(plan_point_params)

    if @plan_point.save
      render json: @plan_point
    else
      render json: { errors: @plan_point.errors.full_messages }
    end
  end

  def destroy
    @plan_point = PlanPoint.find params[:id]
    @plan = Plan.find params[:plan_id]
    @plan_point.destroy
    redirect_to plan_path(@plan)
  end

  private

  def plan_point_params
    params.require(:plan_point).permit(:plan_id, :tour_id, :from_time, :to_time, :day_date)
  end
end
