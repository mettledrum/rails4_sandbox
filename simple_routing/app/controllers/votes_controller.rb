class VotesController < ApplicationController
  before_action :set_vote, only: [:destroy]
  before_action :set_user, only: [:up_vote, :down_vote]

  # TODO: make ajax
  def up_vote
    # :name is model name vote is attached to thru VariadicItem
    @vote = Vote.find_or_create_by(
      user_id: @user.id, 
      item_id: params[:item_id], 
      item_type_id: ItemType.find_by_name(params[:name]).id)

    @vote.value = 1

    if @vote.save
      flash[:notice] = "Up-voted."
    else
      flash[:error] = "Vote not saved."
    end
    redirect_to front_page_path
  end

  # TODO: make ajax
  def down_vote
    # :name is model name vote is attached to thru VariadicItem
    @vote = Vote.find_or_create_by(
      user_id: @user.id, 
      item_id: params[:item_id], 
      item_type_id: ItemType.find_by_name(params[:name]).id)

    @vote.value = -1

    if @vote.save
      flash[:notice] = "Down-voted."
    else
      flash[:error] = "Vote not saved."
    end
    redirect_to front_page_path    
  end

  # TODO: make ajax
	def destroy
		@vote.destroy
    flash[:notice] = "Vote cancelled."
		redirect_to front_page_path
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :value)
    end
end
