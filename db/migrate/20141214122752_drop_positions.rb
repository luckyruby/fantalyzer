class DropPositions < ActiveRecord::Migration
  def up
    drop_table :player_positions
    drop_table :positions
    remove_column :players, :position
  end

  def down
    add_column :players, :position, :string
    create_table :positions do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :positions, :name, unique: true

    create_table :player_positions do |t|
      t.integer :player_id, null: false
      t.integer :position_id, null: false
      t.timestamps
    end
    add_index :player_positions, [:player_id, :position_id], unique: true
  end
end
