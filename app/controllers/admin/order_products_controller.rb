class Admin::OrderProductsController < ApplicationController

  def update
    @order_products = OrderProduct.find(params[:id])
    @order_products.update(orders_params)
     redirect_to admin_order_path(@order_products.order.id)

    #注文IDが同一の注文商品の数と製作ステータスが製作完了の注文商品の数を取得
    orders_count = OrderProduct.where(order_id: @order_products.order_id).count
    madefinish_count = OrderProduct.where(order_id: @order_products.order_id, production_status: 3).count
    # 数が同一だったら（すべての注文商品が製作完了になったら）注文ステータスを発送準備中にする
    if orders_count == madefinish_count
      @order_products.order.update(status: 2)
    end

  end

  def orders_params
      params.require(:order_product).permit(:production_status)
  end
end
