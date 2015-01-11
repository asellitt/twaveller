class Area < ActiveRecord::Base
  has_many :attractions

  def total
    Money.new(attractions.collect(&:cost).sum, currency_code)
  end
end
