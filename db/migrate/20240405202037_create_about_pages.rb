# frozen_string_literal: true

# Create About Page
class CreateAboutPages < ActiveRecord::Migration[7.1]
  def change
    create_table :about_pages do |t|
      t.string :title
      t.string :context

      t.timestamps
    end
  end
end
