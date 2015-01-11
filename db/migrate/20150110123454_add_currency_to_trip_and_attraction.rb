class AddCurrencyToTripAndAttraction < ActiveRecord::Migration
  def change
    add_column :trips, :currency_code, :string, default: 'aud'
    add_column :attractions, :currency_code, :string, default: 'aud'
  end
end
