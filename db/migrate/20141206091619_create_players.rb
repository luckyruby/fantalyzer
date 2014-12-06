class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :yahoo_id
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
    add_index :players, :yahoo_id, unique: true
    add_index :players, [:first_name, :last_name], unique: true
    add_index :players, :last_name
  end
end
