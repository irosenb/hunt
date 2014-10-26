class ChangeUserColumn < ActiveRecord::Migration
  def change
    change_column :users, :hunt_id, :integer
    remove_column :users, :integer
  end
end
