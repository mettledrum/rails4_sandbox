# add to join tables
module Votable
	extend ActiveSupport::Concern

	# find the model's votes through vote_item
	# 'has_many :votes' functionality for models like Comments/Postings
	def votes(user=nil)
		if user
			Vote.where(user_id: user.id, item_id: self.id, item_type_id: ItemType.where(name: self.class.to_s.downcase))
		else
			Vote.where(item_id: self.id, item_type_id: ItemType.where(name: self.class.to_s.downcase))
		end
	end

	# pull all points of votes for votable model
	def vote_score
		votes.map(&:value).reduce(:+)
	end
end