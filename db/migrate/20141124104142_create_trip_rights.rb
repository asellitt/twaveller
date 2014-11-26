class CreateTripRights < ActiveRecord::Migration
  def change
    create_table :trip_rights do |t|
      t.references :trip, index: true
      t.references :user, index: true
      t.string :permission

      t.timestamps
    end

    add_index :trip_rights, [:trip_id, :user_id], :unique => true
  end
end
