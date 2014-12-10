class AddCostPerPointToPlayers < ActiveRecord::Migration
  def up
    add_column :players, :cost_per_point, :decimal, precision: 8, scale: 2
    remove_column :players, :value
  end

  def down
    add_column :players, :value, precision: 4, scale: 2
    remove_column :players, :cost_per_point
  end
end
