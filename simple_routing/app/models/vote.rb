class Vote < ActiveRecord::Base
	has_many :vote_items, dependent: :destroy
	belongs_to :user

	validates_presence_of :user

	# TODO: validate :can_only_have_one_vote_from_user

end
