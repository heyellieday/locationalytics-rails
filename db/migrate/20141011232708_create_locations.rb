class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :city
      t.string :address
      t.text :bounds
      t.timestamps
    end
  end
end
