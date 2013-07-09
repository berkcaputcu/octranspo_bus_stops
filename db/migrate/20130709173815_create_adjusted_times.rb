class CreateAdjustedTimes < ActiveRecord::Migration
  def change
    create_table :adjusted_times do |t|
      t.integer :time_left
      t.decimal :age
      t.decimal :latitude, :precision => 10, :scale => 6
      t.decimal :longitude, :precision => 10, :scale => 6
      t.references :stop_time

      t.timestamps
    end
    add_index :adjusted_times, :stop_time_id
  end
end
