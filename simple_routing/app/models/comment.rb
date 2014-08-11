class Comment < ActiveRecord::Base
	belongs_to :posting
	belongs_to :user

	validates_presence_of :posting
	validates_presence_of :user
end
