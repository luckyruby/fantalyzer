class RemoveSalaryFromPlayer < ActiveRecord::Migration
  def up
    remove_column :players, :salary
    remove_column :players, :cost_per_point
  end

  def down
    add_column :players, :cost_per_point, :decimal, precision: 8, scale: 2
    add_column :players, :salary, :integer
  end
end
