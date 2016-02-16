class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.decimal :price
      t.decimal :old_price

      t.integer :sort, default: 0
      t.boolean :active, default: true
      t.integer :views, default: 0

      t.timestamps
    end

    add_index :products, :slug
    add_index :products, :active
  end
end
