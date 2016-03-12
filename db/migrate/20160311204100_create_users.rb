class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :telegram_id
      t.string :first_name
      t.string :last_name
    end
  end
end