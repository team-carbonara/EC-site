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
  end

  def edit
  end

  private
    def order_params
    params.require(:order).permit(:status)
    end
end
