class AddCvToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :cv, :decimal, precision: 4, scale: 3
    add_column :players, :value, :decimal, precision: 4, scale: 3
    add_column :players, :name, :string
  end
end
