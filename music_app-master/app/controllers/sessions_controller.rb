class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(*user_params)
    if user
      login!(user)
      redirect_to bands_url
    else
      flash[:errors] = ["Invalid info"]
      redirect_to new_session_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
