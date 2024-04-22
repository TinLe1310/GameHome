# frozen_string_literal: true

# Add address column to User model
class AddAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :address, :string
  end
end
