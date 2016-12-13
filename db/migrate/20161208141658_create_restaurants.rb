class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :email
      t.string :location
      t.string :name
      t.string :genre
      t.string :website
      t.string :menu

      t.timestamps
    end
  end
end
