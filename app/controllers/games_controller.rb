class GamesController < ApplicationController
  def index
    @games = Game.all
    @games = Game.order(:title).page params[:page]
  end

  def show
    @game = Game.find(params[:id])
  end

  def search
    key_search = "%#{params[:keywords]}%"
    genre = params[:genre]
    @games = Game.where("title LIKE ?", key_search)
    @games = @games.where("genres LIKE '%?%'", genre) if genre.present?
  end
end
