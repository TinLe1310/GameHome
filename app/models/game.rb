class Game < ApplicationRecord
  has_one_attached :image
  has_many :cart_items

  has_many :game_genres
  has_many :genres, through: :game_genres

  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ['created_at', 'title', 'release_date', 'id', 'official_store_price','key_store_price','updated_at']
  end

  def self.ransackable_associations(auth_object = nil)
    ['genres']
  end
end
