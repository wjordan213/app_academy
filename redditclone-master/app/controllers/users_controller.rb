class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      login!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :edit
    end

    def destroy
      User.find(params[:id]).destroy
      redirect_to :new
    end
  end    
end
