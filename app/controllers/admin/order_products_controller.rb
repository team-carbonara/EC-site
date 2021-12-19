class Admin::OrderProductsController < ApplicationController

  def update
    @order_products = OrderProduct.find(params[:id])
    @order_products.update(orders_params)
     redirect_to admin_orders_path
  end

   def orders_params
      params.require(:order_product).permit(:production_status)
    end
end
