class Attraction < ActiveRecord::Base
  encapsulate_as_money :cost
end
