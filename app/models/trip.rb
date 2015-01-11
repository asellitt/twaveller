class Trip < ActiveRecord::Base
  has_many :areas

  def total
    Money.new(areas.collect(&:total).sum, currency_code)
  end
end
