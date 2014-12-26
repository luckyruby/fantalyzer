class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :abbreviation, null: false
      t.string :short_code, null: false
      t.string :conference, null: false
      t.string :division, null: false
      t.timestamps
    end
    add_index :teams, :name, unique: true
    add_index :teams, :abbreviation, unique: true
  end
end
