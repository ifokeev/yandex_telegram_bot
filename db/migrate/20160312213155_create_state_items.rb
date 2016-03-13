class CreateStateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :state_items do |t|
      t.string :path
      t.integer :depth
      t.string :header
      t.text :description

      t.string :type
    end
    add_index :state_items, :path
    add_index :state_items, :depth
    add_index :state_items, :header
    add_index :state_items, :type
  end
end
