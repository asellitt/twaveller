class Trip < ActiveRecord::Base
  has_many :days
end
