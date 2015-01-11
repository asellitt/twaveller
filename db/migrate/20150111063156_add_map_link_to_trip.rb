class AddMapLinkToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :map, :string
  end
end
