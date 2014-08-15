class Posting < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	validates_presence_of :user

	include Votable

	def forest
		comments.where(parent_id: nil).map(&:tree)
	end
end
