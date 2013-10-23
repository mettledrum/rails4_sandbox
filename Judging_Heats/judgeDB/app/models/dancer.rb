class Dancer < ActiveRecord::Base
	has_many :dancer_teams
	has_many :teams, :through => :dancer_teams
end
