class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
    	t.string :stop_id
      t.integer :stop_code
      t.string :stop_name

      t.timestamps
    end
  end
end
