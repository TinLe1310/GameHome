# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

GameGenre.delete_all
Genre.delete_all
Game.delete_all
AdminUser.delete_all

#fetch the filename
filename = Rails.root.join("db/games.csv")

puts "Loading Games from the CSV file: #{filename}"

csv_data = File.read(filename)
games = CSV.parse(csv_data, headers: true, encoding: "utf-8")

games.each do |g|
  puts "Name: #{g['name']}, Release Date: #{g['release_date']}, Official Store Price: #{g['official_store_price']}, Key Store Price: #{g['key_store_price']}"

  game = Game.create(
    title:   g["name"],
    release_date:  g["release_date"],
    official_store_price:  g["official_store_price"],
    key_store_price:     g["key_store_price"],
  )

  genres = g["genres"].split(",").map(&:strip)

  genres.each do |genre_name|
    genre = Genre.find_or_create_by(name: genre_name)
    GameGenre.create(game: game, genre: genre)
  end

end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

puts "Created #{Game.count} Games"
puts "Created #{Genre.count} Genres"
puts "Created #{GameGenre.count} Game Genres"