class UsersController < ApplicationController

  def new
    @user = User.new
    render :new, layout: 'sign_up'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login! @user
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new, layout: 'sign_up'
    end
  end

  def show
    @user = User.find(params[:id])
    @goal = Goal.new

    if @user == current_user
      @complete_goals = @user.complete_goals
      @incomplete_goals = @user.incomplete_goals
    else
      @complete_goals = @user.complete_goals.where('private_or_public = ?', 'public')
      @incomplete_goals = @user.incomplete_goals.where('private_or_public = ?', 'public')
    end
  end

  def index
  end

end
