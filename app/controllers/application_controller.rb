class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  private
  def authorize
    if User.all.empty?
      redirect_to signup_path
      return
    end

    unless current_user
      redirect_to login_path, alert: 'Login is required.'
    end
  end
end

