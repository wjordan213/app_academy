class SessionsController < ApplicationController
  def new
  end

  def create
    begin
      user = User.find_by_credentials(*user_params)
    rescue InvalidInputError
      flash.now[:errors] = ["invalid input"]
      render :new
      return
    end

    login!(user)
    redirect_to user_url(user)
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
