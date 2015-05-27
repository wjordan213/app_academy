class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user, :auth_token


  def login(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout
    session[:session_token]=nil
  end
  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def auth_token
    x = <<-HTML
    <input type="hidden" name="authenticity_token" value=#{form_authenticity_token}>
    HTML

    x.html_safe
  end
end
