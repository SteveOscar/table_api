class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :city, :string
    add_column :users, :phone_number, :string
    add_column :users, :restuarant_confirmed, :boolean
    add_column :users, :is_restaurant, :boolean
    add_column :users, :website, :string
    add_column :users, :genre, :string
    add_column :users, :description, :string
    add_column :users, :menu, :string
  end
end
