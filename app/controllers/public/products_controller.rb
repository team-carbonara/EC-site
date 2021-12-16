class Public::ProductsController < ApplicationController

  def index
    @products = Product.all
    @product_count = Product.count
    @genres = Genre.all
  end

  def show
    @product = Product.find(params[:id])
    @genres = Genre.all

    @quantity_array = []
    @quantity_array = (1..10).to_a

    # @product_order = ProductOrder.new

  end
end
