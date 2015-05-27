class GoalsController < ApplicationController

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      @user = current_user
      render 'users/show'
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    unless @goal.user == current_user
      flash[:errors] = ["Your not allowed to access this page"]
      redirect_to user_url(@goal.user)
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    # @goal.completed = !!params[:goal][:complete]
    if @goal.update(goal_params)
      # fail
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      @user = current_user
      render 'users/show'
    end
  end

  def destroy
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :notes, :due_date, :private_or_public, :completed)
  end

end
