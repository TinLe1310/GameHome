class GamesController < ApplicationController
  def index
    @games = Game.all
    @games = Game.order(:name).page params[:page]
  end

  def show
    @game = Game.find(params[:id])
  end

  def search
    key_search = "%#{params[:keywords]}%"
    genre = params[:genre]
    @games = Game.where("name LIKE ?", key_search)
    @games = @games.where("genres LIKE '%?%'", genre) if genre.present?
  end
end
