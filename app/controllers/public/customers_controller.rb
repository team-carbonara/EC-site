class Public::CustomersController < ApplicationController
  def show
  end

  def edit
  end

  def update
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
end
