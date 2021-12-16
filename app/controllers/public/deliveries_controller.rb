class Public::DeliveriesController < ApplicationController

  def index
    @delivery = Delivery.new
    @deliverys = Delivery.all
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      redirect_to public_deliveries_path, notice: "Success"
    else
      @delivery = Delivery.all
      render 'index'
    end
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to public_deliveries_path, notice: "Success"
    else
      render 'edit'
    end
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    redirect_to public_deliveries_path, notice: "Deleted"
  end

  def delivery_params
    params.require(:delivery).permit(:name, :post_code, :address)
  end


end
