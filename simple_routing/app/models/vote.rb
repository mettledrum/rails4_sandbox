class Vote < ActiveRecord::Base
	has_many :vote_items
	belongs_to :user

	validates_presence_of :user
end
