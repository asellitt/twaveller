class Area < ActiveRecord::Base
  has_many :attractions
  encapsulate_as_money :cost
end
