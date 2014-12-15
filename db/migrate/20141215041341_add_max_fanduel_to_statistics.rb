class AddMaxFanduelToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :max_fanduel, :decimal, precision: 4, scale: 1
  end
end
