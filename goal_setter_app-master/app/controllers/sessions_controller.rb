class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(*user_params)
    if user
      login! user
      redirect_to user_url(user)
    else
      flash[:errors] = ["Incorrect username and/or password"]
      redirect_to :back
    end
  end

  def destroy
    logout!
    redirect_to root_url
  end
end
