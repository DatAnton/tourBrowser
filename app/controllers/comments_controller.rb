class CommentsController < ApplicationController

  def index
    @tour = Tour.find(params[:tour_id])
    respond_to do |format|
      format.html {  }
      format.json  { render json: @tour.comments }
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :tour_id)
  end
end
