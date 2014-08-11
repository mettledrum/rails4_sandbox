class Posting < ActiveRecord::Base
	belongs_to :user
	has_many :postings

	validates_presence_of :user
end
