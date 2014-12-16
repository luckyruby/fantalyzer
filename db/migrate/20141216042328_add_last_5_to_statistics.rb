class AddLast5ToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :last_5, :decimal, precision: 4, scale: 2
  end
end
