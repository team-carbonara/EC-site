class Public::DeliveriesController < ApplicationController

  def index
    @deliverys = Delivery.all
    @delivery = Delivery.new
  end

  def edit
    @delivery = Delivery.find(params[id])
  end

  def create
  end

  def update
  end

  def destroy
  end
end
