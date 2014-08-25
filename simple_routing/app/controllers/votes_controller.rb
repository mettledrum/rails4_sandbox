class VotesController < ApplicationController
  before_action :set_vote, only: [:destroy]
  before_action :set_user, only: [:create]

  # TODO: make ajax
	def create
		# all votes are worth 1 point
		vote = Vote.create(user_id: @user.id, value: 1)
		# :name is model name vote is attached to thru VariadicItem
		VoteItem.create(item_type_id: ItemType.find_by_name(params[:name]).id, vote_id: vote.id, item_id: params[:item_id])
    flash[:notice] = "Upvoted."
		redirect_to front_page_path
	end

  # TODO: make ajax
	def destroy
		@vote.destroy
    flash[:notice] = "Upvote removed."
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
