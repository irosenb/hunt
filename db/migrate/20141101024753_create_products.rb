class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :link
      t.references :user, index: true

      t.timestamps
    end
  end
end
