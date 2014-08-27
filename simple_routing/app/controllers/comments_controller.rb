class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :set_posting, except: [:index, :destroy]
  skip_after_filter :set_last_url, :only => [:edit]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new

    # user can't control comment parent ID or posting ID,
    # sent in by link_to 'reply'
    @comment.parent_id = params[:parent_id]
    @comment.posting_id = params[:posting_id]
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    # user can't control user ID
    @comment.user_id = @user.id

    if @comment.save
      redirect_to user_posting_path(@user, @posting), notice: 'Comment was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to last_url, notice: 'Comment was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to last_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_posting
      @posting = Posting.find(params[:posting_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :posting_id, :user_id, :parent_id)
    end
end
