class AddProposedDateToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :proposed_date, :datetime, :after => :link
  end
end
