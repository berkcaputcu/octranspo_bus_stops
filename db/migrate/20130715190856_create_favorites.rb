class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user
      t.references :stop_time

      t.timestamps
    end
    add_index :favorites, [:user_id, :stop_time_id], unique: true
  end
end
