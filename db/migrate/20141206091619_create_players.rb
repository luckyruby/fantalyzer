class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players, id: false do |t|
      t.integer :id, null: false #yahoo id
      t.string :first_name
      t.string :last_name
      t.boolean :active, null: false, default: true
      t.timestamps
    end
    add_index :players, :id, unique: true
    add_index :players, [:first_name, :last_name], unique: true
    add_index :players, :last_name
  end
end
