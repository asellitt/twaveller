class Area < ActiveRecord::Base
  has_many :attractions

  def total
    Money.new(attractions.collect(&:cost).sum)
  end
end
