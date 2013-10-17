class TeamHeat < ActiveRecord::Base
	belongs_to :team
	belongs_to :heat
	belongs_to :judge
end
