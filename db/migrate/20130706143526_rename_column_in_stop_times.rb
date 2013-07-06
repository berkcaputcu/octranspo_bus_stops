class RenameColumnInStopTimes < ActiveRecord::Migration
	def change
		rename_column :stop_times, :time_left, :time_left1
	end
end
