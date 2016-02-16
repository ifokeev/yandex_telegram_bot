require 'refile/attachment/active_record'

class Image < ApplicationRecord
  belongs_to :product
  attachment :file, type: :image
end
