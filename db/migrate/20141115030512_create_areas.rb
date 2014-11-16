class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.references :trip, index: true
      t.string :name
      t.text :description
      t.string :image
      t.string :link

      t.timestamps
    end
  end
end
