class Admin::ProductsController < ApplicationController

  def new
    @genres = Genre.all
    @action = "new"
  end

  def index
    @products = Product.all.page(params[:page]).per(10)
  end

  def create
    @product = Product.new(params_product)
    if @product.save
      redirect_to admin_product_path(@product), notice: "登録しました"
    else
      @action = "new"
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @genres = Genre.all
    @product = Product.find(params[:id])
    @action = "edit"
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(params_product)
      redirect_to admin_product_path(@product), notice: "変更しました"
    else
      render 'edit'
    end
  end

  private

  def params_product
    params.require(:product).permit(:id, :genre_id, :name, :description, :image, :price, :sale_status)
  end

end
