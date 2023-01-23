class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    byebug
    @commentable = if params[:report_id].present?
      Report.find(params[:report_id])
    else
      Post.find(params[:post_id])
    end
    @comment = @commentable.comments.new comment_params
    @user = current_user
    @comment.save
    redirect_to @commentable, notice: "Your comment was successfully posted."
  end
  
  private

    def comment_params
      params.require(:comment).permit(:text)
    end
end