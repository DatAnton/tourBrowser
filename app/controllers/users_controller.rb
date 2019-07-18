class UsersController < ApplicationController
  def profile
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { }
      format.json { render json: @user }
    end
  end

end
