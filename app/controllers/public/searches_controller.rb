class Public::SearchesController < ApplicationController

  def search
    keyword = params["keyword"]
    @products = Product.where("name LIKE ?", '%'+keyword+'%')
    @genres = Genre.all
    @title = '" ' + keyword + ' "の検索結果'
    render "public/products/index.html.erb"
  end

end
