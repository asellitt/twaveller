class Attraction < ActiveRecord::Base

  def cost
    Money.new(super() || 0, currency_code)
  end

  def cost=(amount)
    currency = Money::Currency.find(currency_code)
    super(Money.new(amount * currency.subunit_to_unit, currency).fractional)
  end

private

  def currency
    @currency ||= Money::Currency.find(currency_code)
  end

end
