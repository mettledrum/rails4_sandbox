class VoteItem < ActiveRecord::Base
	belongs_to :vote

	include VariadicItem
end
