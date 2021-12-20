class Public::ProductsController < ApplicationController

  def index
    if params[:genre_id].nil?
      # @products = Product.where(sale_status: true)
      @products = Product.all
      @title = "商品"
    else
      @products = Product.where(sale_status: true, genre_id: params[:genre_id])
      @title = params[:genre_name]
    end
    # @product_count = @products.count
    @genres = Genre.all
  end

  def show
    @product = Product.find(params[:id])
    @genres = Genre.all
    @cart_product = CartProduct.new
  end
end
