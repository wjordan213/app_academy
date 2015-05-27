class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def show
    redirect_to new_session_url unless logged_in?
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      login!(user)
      redirect_to bands_url
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_url
    end
  end
end
