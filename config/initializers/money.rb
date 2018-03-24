require 'money'
require 'money/bank/open_exchange_rates_bank'

oxr = Money::Bank::OpenExchangeRatesBank.new
oxr.cache = 'cache.json'
oxr.app_id = ENV["OPENEXCHANGERATES_APP_ID"]
oxr.update_rates
oxr.ttl_in_seconds = 86400

# the thing that uses the quota
oxr.save_rates

Money.default_bank = oxr
Money.default_bank.get_rate('USD', 'AUD')

# default format
Money.default_formatting_rules = {
  with_currency: true
}
