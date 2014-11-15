class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.references :trip, index: true
      t.string :name
      t.text :description
      t.integer :cost
      t.string :image
      t.string :link

      t.timestamps
    end
  end
end
