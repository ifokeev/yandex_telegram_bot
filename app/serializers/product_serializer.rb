class ProductSerializer < ApplicationSerializer
  attributes :title, :description, :colors, :price, :old_price

  def colors
    object.color_list
  end
end
