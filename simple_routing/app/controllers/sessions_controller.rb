class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to users_path, :notice => "Logged in!"
    else
      flash[:error] = "Invalid email or password"
      redirect_to log_in_path
    end
  end

  def destroy
    reset_session
    redirect_to log_in_path, :notice => "Logged out!"
  end

end