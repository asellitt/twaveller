class Trip < ActiveRecord::Base
  has_many :areas

  def total
    Money.new(areas.collect(&:cost).sum)
  end
end
