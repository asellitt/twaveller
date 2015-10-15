class RemoveCurrencyFromAttraction < ActiveRecord::Migration
  def change
    remove_column :attractions, :currency_code
  end
end
