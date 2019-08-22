class UsersController < ApplicationController
  def profile
    @user = current_user
    @user_tours = Tour.all.where(creator_id: @user.id)
    @num_of_plans = current_user.plans.length
  end

  def show
    @user = User.find(params[:id])
    @user_tours = Tour.all.where(creator_id: @user.id)
  end

  def edit_users
    if current_user.admin
      @users = User.all.where(admin: false)
    else
      redirect_to root_path
    end
  end

  def tours
    @user = User.find params[:id]
    render json: @user.tours
  end

  def edit_count_of_hotels
    @user = User.find params[:user_id]
    if @user.update_attribute(:count_of_hotels, params[:count_of_hotels]) && current_user.admin
      render json: true
    else
      render json: false
    end
  end


  def destroy
    @user = current_user
    @user_tours = Tour.all.where(creator_id: current_user.id)
    @user_tours.each do |tour|
      tour.update_attribute(:creator_id, 0)
    end

    @user.destroy
    redirect_to root_path
  end

  private

  def edit_count_of_hotels_params
    params.require(:user).permit(:count_of_hotels, :user_id)
  end
end
