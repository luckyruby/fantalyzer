class AddMeanToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :mean, :decimal, precision: 4, scale: 1
    add_column :players, :std_dev, :decimal, precision: 4, scale: 1
    add_column :players, :games_played, :integer
  end
end
