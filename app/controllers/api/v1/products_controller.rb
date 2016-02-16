class Api::V1::ProductsController < Api::ApplicationController
  include CleanPagination

  before_action :set_product, on: [:show]

  def index
    max_per_page = 100

    products = Product.category(params[:category]).active.sorted

    paginate products.count, max_per_page, allow_render: false, raise_errors: true do |limit, offset|
      products = products.limit(limit).offset(offset)

      render json: products, each_serializer: ProductSerializer
    end
  rescue RangeError
    _bad_request "invalid pagination range"
  end

  # def category
  #   render json: Product.tagged_with(params[:category], on: :categories)
  # end

  def show
    render json: @product
  end

private
  def set_product
    @product = Product.find_by(slug: params[:slug])
  end
end
