class CoupleDancer < ActiveRecord::Base
  validates_presence_of :dancer_id

  belongs_to :dancer
  belongs_to :couple
end
