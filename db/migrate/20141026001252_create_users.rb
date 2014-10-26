class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :hunt_id
      t.string :integer

      t.timestamps
    end
  end
end
