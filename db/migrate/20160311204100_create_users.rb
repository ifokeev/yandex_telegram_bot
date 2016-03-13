class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :telegram_user_id
      t.integer :telegram_chat_id

      t.string :first_name
      t.string :last_name

      t.string :state_item_key
    end
  end
end
