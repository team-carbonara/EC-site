class Public::CartProductsController < ApplicationController
  def index
    @cart_products = current_customer.cart_products.all
    total = [] #空の配列を用意
     @cart_products.each do |cart_product|
      total << cart_product.product.add_tax_price * cart_product.quantity
     end
    @total = total.to_a.sum

  end

  def create
    @cart_product = CartProduct.new(cart_product_params)
    if @cart_product.save
      redirect_to cart_products_path, notice: 'カートに商品を追加しました'
    else
      redirect_to products_path, notice: 'カートに商品を追加するのに失敗しました'
    end
  end

  def update
    @cart_product = current_customer.cart_products.find(params[:id])
    if  @cart_product.update(cart_product_params)
    redirect_to cart_products_path ,notice:"カート内容を変更しました"
    else
    redirect_to cart_products_path ,notice:"カート内容を変更に失敗しました"
    end
  end

  def destroy
    @cart_product = current_customer.cart_products.find_by(params[:id])
    @cart_product.destroy
    redirect_to cart_products_path ,notice:"削除しました"
  end

  def destroy_all
    current_customer.cart_products.destroy_all
    redirect_to cart_products_path ,notice:"削除しました"
  end

  private
  def cart_product_params
      params.require(:cart_product).permit(:product_id,:customer_id, :quantity )
  end
end
# {"cart_product" => {"product_id"=> "値", "customer_id"=> "値", "quantiry" => "値"}}