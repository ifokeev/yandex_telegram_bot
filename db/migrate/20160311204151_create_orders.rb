class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :state, :index => true
      t.jsonb :meta, default: {}, null: false

      t.timestamps
    end

    add_index  :orders, :meta, using: :gin
  end
end
