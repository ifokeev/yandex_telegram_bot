class User < ApplicationRecord
  has_many :locations

  scope :telegram, ->(id) { where(telegram_id: id) }
end
