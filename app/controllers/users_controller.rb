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

  def index_for_hotels
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


  def destroy
    @user = current_user
    @user_tours = Tour.all.where(creator_id: current_user.id)
    @user_tours.each do |tour|
      tour.update_attribute(:creator_id, 0)
    end
    puts "HERE"
    @user.destroy
    redirect_to root_path
  end
end
