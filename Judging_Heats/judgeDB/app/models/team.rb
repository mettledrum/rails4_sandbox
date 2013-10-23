class Team < ActiveRecord::Base
	has_many :dancer_teams
	has_many :dancers, :through => :dancer_teams

	has_many :team_heats
	has_many :judges, :through => :team_heats
	has_many :heats, :through => :team_heats
end
