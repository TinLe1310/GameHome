class Genre < ApplicationRecord
  has_many :game_genres
  has_many :games, through: :game_genres

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["games"]
  end
end
