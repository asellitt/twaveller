class AddDateToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :start_date, :datetime, :after => :name
    add_column :trips, :end_date, :datetime, :after => :start_date
  end
end
