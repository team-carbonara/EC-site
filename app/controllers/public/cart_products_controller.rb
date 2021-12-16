class Public::CartProductsController < ApplicationController
  def index

  end

  def create


    @cart_product = CartProduct.new(cart_product_params)

    if @cart_product.save
      redirect_to public_cart_products_path, notice: 'カートに商品を追加しました'
    else
      redirect_to public_product_path, notice: 'カートに商品を追加するのに失敗しました'
    end
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  private
  def cart_product_params
      params.require(:cart_product).permit(:product_id,:customer_id, :quantity )
  end
end
