class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  # before_action :set_comment, only: :create

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment added"
      redirect_to @micropost
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :micropost_id, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
