class SessionsController < ApplicationController
  def new
    render :new
  end

  def destroy
    logout
    redirect_to cats_url
  end

    # verify username/password
    # reset session token
    # update the session
    # redirect user to cats index

    # verify
  def create
    user = User.find_by_credentials(*user_params.values)
    if user
      login(user)
      redirect_to cats_url
    else
      redirect_to login_url
    end


  end

  def user_params
    params[:user].permit(:user_name, :password)
  end


  private

  def logout
    session[:session_token] = nil
  end
end
