class AddConfidenceIntervalToPlayers < ActiveRecord::Migration
  def up
    add_column :players, :confidence_interval, :decimal, precision: 4, scale: 2
    Player.update_statistics
  end

  def down
    remove_column :players, :confidence_interval
  end
end
