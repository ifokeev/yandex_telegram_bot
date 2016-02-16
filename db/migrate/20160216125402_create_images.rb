class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.references :product, foreign_key: true
      t.string :file_id
      t.integer :sort, default: 0

      t.timestamps
    end
  end
end
