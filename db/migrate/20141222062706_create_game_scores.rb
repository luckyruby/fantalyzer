class CreateGameScores < ActiveRecord::Migration
  def change
    create_table :game_scores do |t|
      t.date :game_date
      t.string :winner
      t.string :loser
      t.integer :winner_points
      t.integer :loser_points
      t.string :home
      t.timestamps
    end
    add_index :game_scores, [:winner, :game_date, :loser], unique: true
    add_index :game_scores, [:loser, :game_date, :winner], unique: true
  end
end
