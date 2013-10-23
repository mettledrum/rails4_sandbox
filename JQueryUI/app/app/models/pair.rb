class Pair < ActiveRecord::Base
  validates_presence_of :dancer1_id
  validates_presence_of :dancer2_id
end
