class Trip < ActiveRecord::Base
  has_many :days

  def total
    days.collect(&:cost).sum
  end
end
