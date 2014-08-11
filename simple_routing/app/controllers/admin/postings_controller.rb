class Admin::PostingsController < ApplicationController
  before_action :set_posting, only: [:show, :edit, :update, :destroy]

  def index
    @postings = Posting.all
  end

  def show
  end

  def new
    @posting = Posting.new
  end

  def edit
  end

  def create
    @posting = Posting.new(posting_params)

    respond_to do |format|
      if @posting.save
        format.html { redirect_to [:admin, @posting], notice: 'Posting was successfully created.' }
        format.json { render action: 'show', status: :created, location: [:admin, @posting] }
      else
        format.html { render action: 'new' }
        format.json { render json: @posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @posting.update(posting_params)
        format.html { redirect_to [:admin, @posting], notice: 'Posting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @posting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @posting.destroy
    respond_to do |format|
      format.html { redirect_to admin_postings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_posting
      @posting = Posting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def posting_params
      params.require(:posting).permit(:title, :content, :user_id)
    end
end
