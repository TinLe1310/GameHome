# frozen_string_literal: true

# Create
class GameGenre < ApplicationRecord
  belongs_to :game
  belongs_to :genre

  def self.ransackable_associations(_auth_object = nil)
    %w[games genres]
  end
end
