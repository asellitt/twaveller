class Day < ActiveRecord::Base
  encapsulate_as_money :cost
end
