class TeamHeat < ActiveRecord::Base
	belongs_to :team
	belongs_to :heat
	belongs_to :judge

	# only one judge score can be given per team per heat
	validates_uniqueness_of :judge_id, :scope => [:heat_id, :team_id]
end
