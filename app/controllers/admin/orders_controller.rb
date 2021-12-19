class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @orders = Order.find(params[:id])
  end

  def edit
  end
end
