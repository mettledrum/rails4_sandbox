class Vote < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :user
	validates_presence_of :item_id
	validates_presence_of :item_type

	validates_uniqueness_of :user, scope: [:item_id, :item_type_id]

	# attaches models to vote
	include VariadicItem

	# TODO: validate :can_only_have_one_vote_from_user

end
