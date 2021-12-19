class Customer::CartProductsController < ApplicationController
  before_action :authenticate_admin!

  def destroy_all
    current_customer.cart_products.destroy_all
    redirect_to cart_products_path ,notice:"削除しました"
  end
end
