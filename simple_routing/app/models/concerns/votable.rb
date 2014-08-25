# add to join tables
module Votable
	extend ActiveSupport::Concern

	# find the model's votes through vote_item
	# 'has_many :votes' functionality for models like Comments/Postings
	def votes
		VoteItem.where(item_id: self.id, item_type_id: ItemType.where(name: self.class.to_s.downcase)).flat_map(&:vote)
	end

	# find model's votes that the current user has made
	# TODO: validate only one exists per user
	# def current_user_vote
	# 	self.votes.keep_if { |v| v.user_id == @current_user.id }.first
	# end
end