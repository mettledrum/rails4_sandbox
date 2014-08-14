# add to join tables
module Votable
	extend ActiveSupport::Concern

	# find the model's votes through vote_item
	def votes
		VoteItem.where(item_id: self.id, item_type_id: ItemType.where(name: self.class.to_s.downcase)).flat_map(&:vote)
	end
end