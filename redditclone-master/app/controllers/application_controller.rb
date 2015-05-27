class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :auth_token

  def auth_token
    x = <<-HTML
      <input type="hidden" name="authenticity_token" value="#{form_authenticity_token}">
    HTML
    x.html_safe
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    session[:session_token] = user.reset_token
  end

  def logged_in?
    !!current_user
  end

  def logout!
    session[:session_token] = nil
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
