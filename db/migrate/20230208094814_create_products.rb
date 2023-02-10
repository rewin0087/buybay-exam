class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :reference
      t.string :name
      t.string :category
      t.decimal :price
      t.references :destination, null: true, foreign_key: true

      t.timestamps
    end
  end
end
