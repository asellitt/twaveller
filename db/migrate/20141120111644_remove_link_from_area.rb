class RemoveLinkFromArea < ActiveRecord::Migration
  def change
    remove_column :areas, :link
  end
end
