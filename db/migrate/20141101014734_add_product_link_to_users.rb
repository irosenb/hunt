class AddProductLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :product_link, :string
  end
end
