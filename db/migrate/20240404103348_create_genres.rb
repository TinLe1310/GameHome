# frozen_string_literal: true

# Create
class CreateGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :genres do |t|
      t.string :name

      t.timestamps
    end
  end
end
