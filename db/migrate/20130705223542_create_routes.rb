class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :no
      t.string :direction

      t.timestamps
    end
  end
end
