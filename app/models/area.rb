class Area < ActiveRecord::Base
  has_many :attractions, dependent: :destroy
  validates_with CurrencyCodeValidator

  def total
    attractions.collect(&:cost).sum.exchange_to(currency_code)
  end
end
