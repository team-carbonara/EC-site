class Public::ProductsController < ApplicationController

  def index
    @products = Product.all
    @product_count = Product.count
    @genres = Genre.all
  end

  def show
    @product = Product.find(params[:id])
    @genres = Genre.all
    @cart_product = CartProduct.new
  end
end
