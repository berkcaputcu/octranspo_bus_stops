class CreateStopTimes < ActiveRecord::Migration
  def change
    create_table :stop_times do |t|
      t.references :stop
      t.references :route
      t.integer :time_left

      t.timestamps
    end
    add_index :stop_times, [:stop_id, :route_id], unique: true
  end
end
