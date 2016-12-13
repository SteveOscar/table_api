class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :location
      t.string :name
      t.string :uid
      t.boolean :is_restaurant
      t.string :genre
      t.string :website
      t.string :menu

      t.timestamps
    end
  end
end
