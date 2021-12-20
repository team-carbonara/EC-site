class Public::DeliveriesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @delivery = Delivery.new
    # @deliverys = Delivery.all
    @deliverys = current_customer.deliveries
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    @deliverys = current_customer.deliveries
    @delivery.save
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to deliveries_path, notice: "Success!"
    else
      render 'edit'
    end
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    @deliverys = current_customer.deliveries
  end

  def delivery_params
    params.require(:delivery).permit(:name, :post_code, :address)
  end


end
