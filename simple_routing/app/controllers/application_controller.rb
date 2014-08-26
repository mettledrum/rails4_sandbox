class ApplicationController < ActionController::Base
  # remember last GET
  append_after_action :set_last_url
  append_after_action :set_last_delete_url

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :ensure_user

  helper_method :current_user

	private 

  # pull current ActiveRecord user from session
	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

  # go to login page unless a user is signed in
  def ensure_user
    unless current_user
      flash[:error] = "You must have an account and log in!"
      redirect_to preview_path
    end
  end

  # set the last url that was called as the current path (for later redirects)
  def set_last_url
    session[:last_url] = request.fullpath if request.method.casecmp('get') == 0
  end
  def last_url
    session[:last_url]
  end

  # for controllers to skip so deleted endpoint is not traversed to
  def set_last_delete_url
    session[:last_delete_url] = request.fullpath if request.method.casecmp('get') == 0
  end
  def last_delete_url
    session[:last_delete_url]
  end
end
