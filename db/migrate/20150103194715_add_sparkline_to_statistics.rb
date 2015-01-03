class AddSparklineToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :sparkline, :text
  end
end
