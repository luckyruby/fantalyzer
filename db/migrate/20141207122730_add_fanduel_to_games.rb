class AddFanduelToGames < ActiveRecord::Migration
  def change
    add_column :games, :fanduel, :decimal, precision: 4, scale: 1
  end
end
