class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :email
      t.string :uid
      t.string :genre
      t.string :website
      t.string :menu
      t.string :description
      t.integer :zip
      t.string :location
      t.boolean :verified

      t.timestamps
    end
  end
end
