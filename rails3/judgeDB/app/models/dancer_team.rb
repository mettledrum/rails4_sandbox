class DancerTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :dancer
end
