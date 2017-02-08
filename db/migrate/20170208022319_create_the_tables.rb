class CreateTheTables < ActiveRecord::Migration[5.0]
  def change
    create_table :the_tables do |t|
      t.references :restaurant, foreign_key: true
      t.datetime :time
      t.string :description
      t.string :discount
      t.boolean :food
      t.boolean :drinks
      t.integer :max_people
      t.boolean :reserved

      t.timestamps
    end
  end
end
