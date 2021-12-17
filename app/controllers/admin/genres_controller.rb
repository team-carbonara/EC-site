class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(params_genre)
    if @genre.save
      redirect_to request.referer, notice: "登録しました"
    else
      @genre = Genre.new
      @genres = Genre.all
      render 'index'
    end
  end

  def edit
    @genre = Genre.find(params[:id])

  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(params_genre)
      redirect_to admin_genres_path(@genre), notice: "登録しました"
    else
      render 'edit'
    end
  end

  private

  def params_genre
    params.require(:genre).permit(:name)
  end

end
