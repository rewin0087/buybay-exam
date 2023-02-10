class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :references, array: true, default: '[]'
      t.string :categories, array: true, default: '[]'
      t.decimal :maximum_price

      t.timestamps
    end
  end
end
