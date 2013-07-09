class RemoveTimeLeft1AndTimeLeft2AndTimeLeft3FromStopTimes < ActiveRecord::Migration
  def up
    remove_column :stop_times, :time_left1
    remove_column :stop_times, :time_left2
    remove_column :stop_times, :time_left3
  end

  def down
    add_column :stop_times, :time_left3, :integer
    add_column :stop_times, :time_left2, :integer
    add_column :stop_times, :time_left1, :integer
  end
end
