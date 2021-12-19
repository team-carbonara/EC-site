class Public::OrdersController < ApplicationController
  def index
    @orders = current_customer.orders.all

  end

  def show
    @order = current_customer.orders.find(params[:id])

  end

  def new
        if current_customer.cart_products.count != 0
  @cart_products = current_customer.cart_products.all
  total = [] #空の配列を用意
   @cart_products.each do |cart_product|
    total << cart_product.product.add_tax_price * cart_product.quantity
   end
  @total = total.to_a.sum
  @order = Order.new
    else
      redirect_to cart_products_path,notice: 'カートに商品を入れてください'
    end
  end

  def create
    cart_products = current_customer.cart_products.all
    @order = current_customer.orders.new(orders_params)

    if @order.save
      cart_products.each do |cart|
        order_product = OrderProduct.new
        order_product.product_id = cart.product_id
        order_product.order_id = @order.id
        order_product.quantity = cart.quantity
        order_product.price = cart.product.price
        order_product.save
      end
      redirect_to thanks_orders_path
      cart_products.destroy_all
    else
      @order = Order.new(orders_params)
      render :new
    end
  end

  def check

    @postage = 800
    @cart_products = current_customer.cart_products.all
    total = [] #空の配列を用意
     @cart_products.each do |cart_product|
      total << cart_product.product.add_tax_price * cart_product.quantity
     end
    @total = total.to_a.sum
      if params[:order][:payment_method] == Order.payment_methods.key(0)
        @payment_method = Order.payment_methods.key(0)
      elsif params[:order][:payment_method] == Order.payment_methods.key(1)
        @payment_method = Order.payment_methods.key(1)
      end

     @order = Order.new(order_params)
      if params[:order][:address_number] == "1"
        @order.name = current_customer.first_name
        @order.post_code = current_customer.post_code
        @order.address = current_customer.address

      elsif params[:order][:address_number] == "2"
        if Delivery.exists?(params[:order][:registered])
          @order.name = Delivery.find(params[:order][:registered]).name
          @order.address = Delivery.find(params[:order][:registered]).address
          @order.post_code = Delivery.find(params[:order][:registered]).post_code
        else

          render :new
        end

      elsif params[:order][:address_number] == "3"
        address_new = current_customer.deliveries.new(address_params)
        @order.name = address_new.name
        if address_new.save
        else
          render :new
        end
      else
        redirect_to 遷移したいページ
      end

  end

  def thanks
  end

  private
  def order_params
  params.require(:order).permit(:name,:post_code, :address, :total_price)
  end

  def address_params
    params.require(:order).permit(:name,:post_code, :address)
  end
  def orders_params
    params.require(:order).permit(:customer_id,:post_code, :address, :name, :payment_method, :postage, :total_price, :status )
  end
end
