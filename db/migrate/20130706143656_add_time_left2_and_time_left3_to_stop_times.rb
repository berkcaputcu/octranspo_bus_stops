class AddTimeLeft2AndTimeLeft3ToStopTimes < ActiveRecord::Migration
  def change
    add_column :stop_times, :time_left2, :integer
    add_column :stop_times, :time_left3, :integer
  end
end
