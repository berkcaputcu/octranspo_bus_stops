class AddExpiresAtAndLatAndLongToStops < ActiveRecord::Migration
  def change
    add_column :stops, :expires_at, :datetime
    add_column :stops, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :stops, :long, :decimal, {:precision=>10, :scale=>6}
  end
end
