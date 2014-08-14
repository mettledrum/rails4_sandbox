class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :ensure_user

  helper_method :current_user

	private 

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

  # go to login page unless a user is signed in
  def ensure_user
    unless current_user
      flash[:error] = "You must have an account and log in!"
      redirect_to log_in_path
    end
  end

end
