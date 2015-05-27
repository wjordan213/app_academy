class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user, :auth_token
  def auth_token
    x = <<-HTML
    <input type="hidden" name="authenticity_token"
    value="#{form_authenticity_token}">
    HTML

    x.html_safe
  end

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def user_params
    params[:user].permit(:email, :password)
  end

  def is_logged_in?
    redirect_to new_session_url unless logged_in?
  end
end
