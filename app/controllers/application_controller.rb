class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    session[:user_id] != nil
  end
  helper_method :logged_in?

  private

  def not_authenticated
    redirect_to login_path, alert: "You must log in first"
  end

  def require_login
    if !logged_in?
      not_authenticated
    end
  end
end
