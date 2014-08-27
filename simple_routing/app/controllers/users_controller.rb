class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :ensure_user, only: [:new, :create]

  before_filter :ensure_admin, only: [:index]

  # redirection methods
  skip_after_filter :set_last_url, :only => [:edit]
  skip_after_filter :set_last_delete_url, :only => [:show, :new, :edit]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # TODO: log_in user too
      redirect_to log_in_path, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # TODO: log_out, end session too
  def destroy
    # allows admin to destroy users w/o being logged out themselves
    if @user.id == current_user.id
      reset_session
      @user.destroy
      flash[:notice] = "You've successfully deleted your account."
      redirect_to preview_path
    else
      @user.destroy
      flash[:notice] = "User successfully destroyed."
      redirect_to last_delete_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
