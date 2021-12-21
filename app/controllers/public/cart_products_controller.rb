class Public::CartProductsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_products = current_customer.cart_products.all
  end

  def create
    @cart_product = current_customer.cart_products.new(cart_product_params)

    if current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id]).present?
      add_product = current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id])
      add_product.quantity += params[:cart_product][:quantity].to_i
      add_product.save
      redirect_to cart_products_path, notice: '商品の個数が変更されました'
    elsif @cart_product.save
      redirect_to cart_products_path, notice: 'カートに商品を追加しました'
    else
      redirect_to products_path, notice: 'カートに商品を追加するのに失敗しました'
    end
  end

  def update
    @cart_product = current_customer.cart_products.find(params[:id])
    if  @cart_product.update(cart_product_params)
    @cart_products = current_customer.cart_products.all
    render :index

    else
    redirect_to cart_products_path ,notice:"カート内容を変更に失敗しました"
    end
  end

  def destroy
    @cart_product = current_customer.cart_products.find(params[:id])
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