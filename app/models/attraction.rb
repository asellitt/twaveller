class Attraction < ActiveRecord::Base
  belongs_to :area

  def cost
    Money.new(super() || 0, currency_code)
  end

  def cost=(amount)
    super(Money.new(amount * currency.subunit_to_unit, currency).fractional)
  end

private

  delegate :currency_code, to: :area

  def currency
    @currency ||= Money::Currency.find(currency_code)
  end

end
