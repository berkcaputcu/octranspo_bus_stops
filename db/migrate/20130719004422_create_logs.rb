class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :user
      t.references :stop_time

      t.timestamps
    end
    add_index :logs, [:user_id, :stop_time_id], unique: true
  end
end
