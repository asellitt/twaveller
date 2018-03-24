class CurrencyCodeValidator < ActiveModel::Validator
  def validate(record)
    begin
      Money.new(1_00).exchange_to(record.currency_code)
    rescue Money::Currency::UnknownCurrency
      message = "I'm sorry, I don't know any conversion rates for #{record.currency_code}"
      record.errors[:currency_code] << message
    end
  end
end
