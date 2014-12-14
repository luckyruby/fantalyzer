class CreateStatistics < ActiveRecord::Migration
  def up
    create_table :statistics do |t|
      t.integer :player_id
      t.decimal :mean, precision: 4, scale: 2
      t.decimal :std_dev, precision: 4, scale: 2
      t.decimal :cv, precision: 4, scale: 3
      t.decimal :confidence_interval, precision: 4, scale: 2
      t.integer :games_played
      t.timestamps
    end
    add_index :statistics, :player_id, unique: true

    remove_column :players, :mean
    remove_column :players, :std_dev
    remove_column :players, :cv
    remove_column :players, :confidence_interval
    remove_column :players, :games_played

    add_index :players, :name, unique: true
  end

  def down
    remove_index :players, :name
    add_column :players, :games_played, :integer
    add_column :players, :confidence_interval, :decimal, precision: 4, scale: 2
    add_column :players, :cv, :decimal, precision: 4, scale: 3
    add_column :players, :std_dev, :decimal, precision: 4, scale: 2
    add_column :players, :mean, :decimal, precision: 4, scale: 2
    drop_table :statistics
  end
end
