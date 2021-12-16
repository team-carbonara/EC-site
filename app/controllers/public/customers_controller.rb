class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_customers_path, notice: "Success!"
    else
      render 'edit'
    end
  end

  def unsubscribe
    # @customer = Customer.find_by(name: params[:name])
  end

  def withdrawal
    # @customer = Customer.find_by(name: params[:name])
    # @customer.update(is_valid: false)
    # reset_session
    # redirect_to root_path
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,  :post_code, :address, :tel, :email)
  end


end
