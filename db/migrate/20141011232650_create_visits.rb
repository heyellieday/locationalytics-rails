class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :length
      t.integer :location_id
      t.timestamps
    end
  end
end
