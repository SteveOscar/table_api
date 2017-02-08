class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.integer :zip
      t.string :location
      t.string :uid
      t.string :tables

      t.timestamps
    end
  end
end
