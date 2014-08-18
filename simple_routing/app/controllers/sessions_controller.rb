class SessionsController < ApplicationController
  # allow user to go to log_in or sign_up
  skip_before_filter :ensure_user, :only => [:new, :create]

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to front_page_path, :notice => "Logged in!"
    else
      flash[:error] = "Invalid email or password."
      redirect_to log_in_path
    end
  end

  def destroy
    reset_session
    redirect_to log_in_path, :notice => "Logged out!"
  end

end