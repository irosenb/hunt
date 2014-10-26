class AddHuntedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hunted_at, :datetime
  end
end
