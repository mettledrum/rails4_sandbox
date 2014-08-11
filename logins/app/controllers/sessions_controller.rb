class SessionsController < ApplicationController
	def create
		# security variables
		fail_max = 2
		timeout = 1.minutes

		@user = User.find_by_email(user_params[:email].downcase)

		# locked out for a bit
		if session[:login_fail_count] && session[:login_fail_count] > fail_max && session[:last_fail_time]+timeout > Time.now
			flash[:error] = 'Temporarily locked out due to password fails.'
			redirect_to login_path
		# must authenticate through email loop
		elsif @user && !@user.authenticated
			flash[:error] = 'Please confirm your account via the e-mail you received upon registering.'
			redirect_to login_path
		# successful
		elsif @user && @user.password_digest == user_params[:password_digest]
			session[:user] = {id: @user.id}
			flash[:notice] = 'Logged in successfully.'
			# reset foul play info in session
			session[:login_fail_count] = 0
			redirect_to user_path(@user)
		# wrong password/email combo
		else
			flash[:error] = 'Incorrect login info.'
			# record mistakes for possible foul play
			session[:last_fail_time] = Time.now
			session[:login_fail_count] ? session[:login_fail_count] = session[:login_fail_count]+1 : session[:login_fail_count] = 0
			redirect_to login_path
		end
	end

	def new
		# don't have to login if already in session
		redirect_to user_path(User.find(session[:user][:id])) if session[:user] && session[:user][:id]
		@user = User.new
	end

	def destroy
		reset_session
		flash[:notice] = 'You logged off successfully.'
		redirect_to login_path
	end

	private

 	def user_params
		params.require(:user).permit(:email, :password_digest)
	end
end
