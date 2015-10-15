class Trip < ActiveRecord::Base
  has_many :areas, dependent: :destroy
  has_many :trip_rights, dependent: :destroy
  validates_with CurrencyCodeValidator

  def total
    areas.collect(&:total).sum.exchange_to(currency_code)
  end
end
