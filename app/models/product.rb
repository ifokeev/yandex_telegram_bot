require 'refile/attachment/active_record'

class Product < ApplicationRecord
  # acts_as_taggable
  acts_as_taggable_on :categories, :colors

  has_many :images, dependent: :destroy
  accepts_attachments_for :images, attachment: :file, append: true

  scope :sorted, -> { order('products.sort DESC') }
  scope :active, -> { where('products.active = ?', true) }

  def self.category(category)
    if category
      tagged_with(category, on: :categories, order: 'tags.sort DESC')
    else
      all
    end
  end
end
