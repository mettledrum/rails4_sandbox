class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_user
  before_action :set_posting

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

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_posting_comment_path(@user, @posting, @comment), notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to user_posting_comment_path(@user, @posting, @comment), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to user_posting_comments_url(@user, @posting) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def set_posting
      @posting = Posting.find(params[:posting_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :posting_id, :user_id, :parent_id)
    end
end
