class Judge < ActiveRecord::Base
	has_many :team_heats
	has_many :teams, :through => :team_heats
	has_many :heats, :through => :team_heats
end
