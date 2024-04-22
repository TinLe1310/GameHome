# frozen_string_literal: true

# Create Taxes model
class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes do |t|
      t.string :province
      t.float :PST
      t.float :GST
      t.float :HST

      t.timestamps
    end
  end
end
