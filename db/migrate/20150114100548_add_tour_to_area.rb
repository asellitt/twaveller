class AddTourToArea < ActiveRecord::Migration
  def change
    add_column :areas, :tour, :integer, default: 0
  end
end
