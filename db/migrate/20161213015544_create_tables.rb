class CreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table :tables do |t|
      t.datetime :time
      t.string :description
      t.integer :discount
      t.boolean :food
      t.boolean :drinks
      t.integer :max_people
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
