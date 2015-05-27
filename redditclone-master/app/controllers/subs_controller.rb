class SubsController < ApplicationController
  before_action :user_is_logged_in?, only: [ :new, :create, :edit, :update]
  before_action :user_is_mod?, only: [ :edit, :update ]
  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  private
    def sub_params
        params.require(:sub).permit(:user_id, :title, :description)
    end

    def user_is_mod?
      new_sub = Sub.find(params[:id])
      redirect_to user_url(current_user) unless new_sub.mod == current_user
    end

    def user_is_logged_in?
      redirect_to new_session_url unless logged_in?
    end
end
