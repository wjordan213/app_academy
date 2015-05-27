class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = ["comment submitted"]
      if comment.commentable_type == "User"
        redirect_to user_url(comment.commentable_id)
      else
        redirect_to goal_url(comment.commentable_id)
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
