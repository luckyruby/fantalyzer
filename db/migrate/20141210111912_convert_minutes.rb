class ConvertMinutes < ActiveRecord::Migration
  def up
    execute "TRUNCATE games restart identity"
    remove_column :games, :minutes
    add_column :games, :minutes, :decimal, precision: 5, scale: 2
  end

  def down
    remove_column :games, :minutes
    add_column :games, :minutes, :string
  end
end
