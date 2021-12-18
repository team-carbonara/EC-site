class Public::HomesController < ApplicationController
  def top
    @products = Product.where(sale_status: true).limit(4).order("created_at DESC")
    @genres = Genre.all
  end

  def about
  end
end
