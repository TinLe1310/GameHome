class GameGenre < ApplicationRecord
  belongs_to :game
  belongs_to :genre

  def self.ransackable_associations(auth_object = nil)
    ["games","genres"]
  end
end
