class ChangeColumnTypeInGames < ActiveRecord::Migration[7.1]
  def change
    change_column :games, :official_store_price, :string
    change_column :games, :key_store_price, :string
  end
end
