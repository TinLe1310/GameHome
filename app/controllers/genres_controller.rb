class GenresController < ApplicationController
  def index
    @genres = ordered_by_games
  end

  def show
    @genre = Genre.find(params[:id])
  end
end
