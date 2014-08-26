class PostingsController < ApplicationController
  before_action :set_posting, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :except => [:preview]
  skip_before_filter :ensure_user, :only => [:preview]
  skip_after_filter :set_last_url, :only => [:edit]
  skip_after_filter :set_last_delete_url, :only => [:show, :new, :edit]

  # preview the postings on the root
  def preview
    @postings = Posting.all.sort_by {|p| [p.created_at.to_date, p.vote_score]}.reverse.first(3)
  end

  # sort by day and score within day
  def front    
    @postings = Posting.all.sort_by {|p| [p.created_at.to_date, p.vote_score]}.reverse
  end

  # shows users' postings
  def index
  end

  # show the comments forest too
  def show
    @comments = @posting.forest
  end

  def new
    @posting = Posting.new
  end

  def edit
  end

  def create
    @posting = Posting.new(posting_params)

    # user can't control their ID
    @posting.user_id = @user.id

    if @posting.save
      redirect_to user_posting_path(@user, @posting), notice: 'Posting was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @posting.update(posting_params)
      redirect_to last_url, notice: 'Posting was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @posting.destroy
    redirect_to last_delete_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posting
      @posting = Posting.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def posting_params
      params.require(:posting).permit(:title, :content, :user_id)
    end
end
