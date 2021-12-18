class Customer::CartProductsController < ApplicationController
  def destroy_all
    current_customer.cart_products.destroy_all
    redirect_to cart_products_path ,notice:"削除しました"
  end
end
