class AddRefreshCountToStop < ActiveRecord::Migration
  def change
    add_column :stops, :refresh_count, :integer, :default => 0
  end
end
