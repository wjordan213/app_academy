class PostsController < ApplicationController
  wrap_parameters false

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end

  def update
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: @post
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
