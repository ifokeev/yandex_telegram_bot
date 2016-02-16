class Api::V1::CategoriesController < Api::ApplicationController
  def index
    categories = Product.all_tags(on: :categories, order: 'tags.sort DESC')

    render json: categories, each_serializer: CategorySerializer
  end
end
