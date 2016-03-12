class Api::V1::OrdersController < Api::ApplicationController
  include CleanPagination

  before_action :set_order, on: [:show]

  def index
    max_per_page = 100

    orders = Order.sorted

    paginate orders.count, max_per_page, allow_render: false, raise_errors: true do |limit, offset|
      orders = orders.limit(limit).offset(offset)

      render json: orders, each_serializer: OrderSerializer
    end
  rescue RangeError
    _bad_request "invalid pagination range"
  end

  def create
    _success
  end

  def show
  end

private
  def set_order
    @order = Order.find(params[:id])
  end
end
