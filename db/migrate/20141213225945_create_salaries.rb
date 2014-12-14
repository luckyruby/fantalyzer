class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.integer :user_id, null: false
      t.integer :player_id, null: false
      t.string :position, null: false
      t.integer :salary, null: false
      t.decimal :cost_per_point, precision: 8, scale: 2
      t.boolean :late, null: false, default: false
      t.timestamps
    end
    add_index :salaries, [:user_id, :player_id, :late], unique: true
  end
end
