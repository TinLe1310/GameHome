# frozen_string_literal: true

# Create
class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title
      t.datetime :release_date
      t.float :official_store_price
      t.float :key_store_price

      t.timestamps
    end
  end
end
