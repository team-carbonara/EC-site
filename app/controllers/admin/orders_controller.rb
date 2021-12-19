class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @orders = Order.find(params[:id])
  end

  def update
    @orders = Order.find(params[:id])

    if  @orders.update(order_params)
      redirect_to admin_orders_path
    else @orders.order_products.update(orders_params)
    redirect_to admin_orders_path
    end
  end

  def edit
  end



  private
    def order_params
    params.require(:order).permit(:status)
    end


end
