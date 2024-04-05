class Genre < ApplicationRecord
  has_many :game_genres
  has_many :games, through: :game_genres

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["games"]
  end

  def self.ordered_by_games
    self.select("genres.*")
        .select("COUNT(game_genres.genre_id) as game_count")
        .left_joins(:game_genres)
        .group('genres.id')
        .order("game_count DESC")
  end
end
