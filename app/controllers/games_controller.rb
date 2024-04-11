class GamesController < ApplicationController
  def index
    @games = Game.all
    @games = Game.order(:title).page params[:page]
    @genres = Genre.joins(:games).distinct.pluck(:name)
  end

  def show
    @game = Game.find(params[:id])
  end

  def search
    key_search = "%#{params[:keywords]}%"
    genre = params[:genre]
    @games = Game.where("title LIKE ?", key_search)
    @games = @games.joins(game_genres: :genre).where(genres: { name: genre }) if genre.present? && genre != 'All Genres'
  end
end
