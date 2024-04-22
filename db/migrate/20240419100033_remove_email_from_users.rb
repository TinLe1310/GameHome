# frozen_string_literal: true

# Remove email column
class RemoveEmailFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :email
  end
end
