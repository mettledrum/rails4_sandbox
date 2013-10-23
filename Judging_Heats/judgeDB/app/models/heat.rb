class Heat < ActiveRecord::Base
	has_many :team_heats
	has_many :teams, :through => :team_heats
	has_many :judges, :through => :team_heats
end
