class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @orders = Order.find(params[:id])
  end

  def edit
  end
end
