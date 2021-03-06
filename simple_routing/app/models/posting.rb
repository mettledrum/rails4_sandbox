class Posting < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates_presence_of :user

	include Votable

	# trees belonging to a posting
	def forest
		comments.where(parent_id: nil).map(&:tree)
	end
end
