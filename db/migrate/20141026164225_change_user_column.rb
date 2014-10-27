class ChangeUserColumn < ActiveRecord::Migration
  def change
    change_column :users, :hunt_id, 'integer USING CAST("hunt_id" AS integer)'
    remove_column :users, :integer
  end
end
