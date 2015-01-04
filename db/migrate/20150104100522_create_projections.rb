class CreateProjections < ActiveRecord::Migration
  def change
    create_table :projections do |t|
      t.integer :user_id, null: false
      t.integer :player_id, null: false
      t.decimal :points, precision: 4, scale: 1
      t.timestamps
    end
    add_index :projections, [:user_id, :player_id], unique: true
  end
end
