class Trip < ActiveRecord::Base
  has_many :areas, dependent: :destroy
  has_many :trip_rights, dependent: :destroy

  def total
    Money.new(areas.collect(&:total).sum, currency_code)
  end
end
