# frozen_string_literal: true

# Create
class Genre < ApplicationRecord
  has_many :game_genres
  has_many :games, through: :game_genres

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['games']
  end

  validates :name, presence: true, uniqueness: true

  def self.ordered_by_games
    self.select('genres.*')
        .select('COUNT(game_genres.genre_id) as game_count')
        .left_joins(:game_genres)
        .group('genres.id')
        .order('game_count DESC')
  end
end
