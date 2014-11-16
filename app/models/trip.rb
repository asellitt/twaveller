class Trip < ActiveRecord::Base
  has_many :areas

  def total
    Money.new(areas.collect(&:total).sum)
  end
end
