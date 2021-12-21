class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @orders = Order.find(params[:id])
  end

  def update
    @orders = Order.find(params[:id])
    @orders.update(order_params)
    redirect_to admin_order_path(@orders.id)

    # 製作ステータスの更新
    if @orders.status == "入金確認"
      @orders.order_products.each do |order_product|
        order_product.update(production_status: 1)
      end
    end

  end

  def edit
    @customers = Customer.find(params[:id])
  end

  private
    def order_params
    params.require(:order).permit(:status)
    end
end
