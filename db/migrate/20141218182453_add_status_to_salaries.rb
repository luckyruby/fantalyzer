class AddStatusToSalaries < ActiveRecord::Migration
  def change
    add_column :salaries, :status, :string, null: false, default: 'active'
  end
end
