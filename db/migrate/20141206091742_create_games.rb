class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_id, null: false
      t.date :game_date
      t.string :opponent
      t.string :score
      t.time :minutes
      t.integer :field_goals_made
      t.integer :field_goals_attempted
      t.decimal :field_goal_percentage, precision: 4, scale: 1
      t.integer :three_points_made
      t.integer :three_points_attempted
      t.decimal :three_point_percentage, precision: 4, scale: 1
      t.integer :free_throws_made
      t.integer :free_throws_attempted
      t.decimal :free_throw_percentage, precision: 4, scale: 1
      t.integer :offensive_rebounds
      t.integer :defensive_rebounds
      t.integer :rebounds
      t.integer :assists
      t.integer :turnovers
      t.integer :steals
      t.integer :blocks
      t.integer :personal_fouls
      t.integer :points
      t.timestamps
    end
    add_index :games, :player_id
  end
end
