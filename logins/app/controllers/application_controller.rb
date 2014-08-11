class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # extract the current user out of the session if one exists
  def current_user
    session[:user] && session[:user][:id] ? User.find(session[:user][:id]) : User.new
  end
end
