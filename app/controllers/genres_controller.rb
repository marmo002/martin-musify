class GenresController < ApplicationController
  def index
    @genres = Genre.all.order(:name)
  end

  def show
    @genre = Genre.find(params[:id])
    @events = @genre.events.page params[:page]
  end
end
