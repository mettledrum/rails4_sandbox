class VoteItem < ActiveRecord::Base
	belongs_to :vote

	validates_presence_of :vote
	validates_presence_of :item_type
	validates_presence_of :item_id

	include VariadicItem
end
