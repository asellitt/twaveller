class AddCurrencyToArea < ActiveRecord::Migration
  def change
    add_column :areas, :currency_code, :string, default: 'aud'
  end
end
