class RemoveLinkFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :product_link
  end
end
