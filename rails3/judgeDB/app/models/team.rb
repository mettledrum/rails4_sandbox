class Team < ActiveRecord::Base
	has_many :dancer_teams
	has_many :dancers, :through => :dancer_teams
	has_many :judges, :through => :dancer_teams
end
