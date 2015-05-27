class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to comment_url(@comment)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :content, :parent_comment_id)
  end
end
