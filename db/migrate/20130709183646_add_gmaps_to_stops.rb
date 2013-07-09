class AddGmapsToStops < ActiveRecord::Migration
  def change
    add_column :stops, :gmaps, :boolean
  end
end
