class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :mac_id
      t.integer :at_location
      t.timestamps
    end
  end
end
