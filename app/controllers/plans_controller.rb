class PlansController < ApplicationController
  def new
    @plan = Plan.new
  end

  def index
    @plans = current_user.plans
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.update_attribute(:user_id, current_user.id)
    if @plan.save
      render json: @plan
    else
      render json: @plan.errors.full_messages
    end
  end

  def update
    @plan = Plan.find params[:id]
    if @plan.update_attributes(plan_params)
      render json: @plan
    else
      render json: @plan.errors.full_messages
    end
  end

  def destroy
    @plan = Plan.find params[:id]
    @plan.destroy
  end

  def show
    @plan = Plan.find params[:id]
  end

  private

  def plan_params
    params.require(:plan).permit(:name)
  end
end
