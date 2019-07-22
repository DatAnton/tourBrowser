class ToursAndUsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @relation = ToursAndUser.new(tours_and_user_params)
    @relation.save
    render json: @relation
  end

  def delete
    @relation = ToursAndUser.find_by(user_id: params[:user_id], tour_id: params[:tour_id])
    @relation.destroy
  end

  def index
    @relations = ToursAndUser.all
  end

  private

  def tours_and_user_params
    params.require(:tours_and_user).permit(:tour_id, :user_id)
  end
end
