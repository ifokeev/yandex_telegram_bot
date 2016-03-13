class User < ApplicationRecord
  has_many :locations

  scope :telegram_user, ->(id) { where(telegram_user_id: id) }
  scope :telegram_chat, ->(id) { where(telegram_chat_id: id) }

  scope :identity, ->(tuser_id, tchat_id) { 
    telegram_user(tuser_id).telegram_chat(tchat_id)
  }

  def cart
    Cartman::Cart.new(id)
  end
end
