class CreatePlayerPositions < ActiveRecord::Migration
  def change
    create_table :player_positions do |t|
      t.integer :player_id, null: false
      t.integer :position_id, null: false
      t.timestamps
    end
    add_index :player_positions, [:player_id, :position_id], unique: true
  end
end
