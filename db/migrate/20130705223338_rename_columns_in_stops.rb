class RenameColumnsInStops < ActiveRecord::Migration
	def change
		rename_column :stops, :stop_name, :name
		rename_column :stops, :stop_code, :code
	end
end
