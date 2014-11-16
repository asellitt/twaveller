class CreateAttractions < ActiveRecord::Migration
  def change
    create_table :attractions do |t|
      t.references :area, index: true
      t.string :name
      t.text :description
      t.integer :cost
      t.string :image
      t.string :link

      t.timestamps
    end
  end
end
