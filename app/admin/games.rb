# frozen_string_literal: true

ActiveAdmin.register Game do
  permit_params :title, :release_date, :official_store_price, :key_store_price, :image, genre_ids: []
  filter :genres_id_eq, as: :select, collection: -> { Genre.all.map { |genre| [genre.name, genre.id] } }
  remove_filter :image_attachment, :image_blob

  index do
    selectable_column
    id_column
    column :title
    column :release_date
    column :official_store_price
    column :key_store_price
    column 'Genres' do |game|
      game.genres.map(&:name).join(', ').html_safe
    end
    column 'Image' do |game|
      image_tag(game.image) if game.image.present?
    end
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ''
      f.input :genres, as: :check_boxes
    end
    f.actions
  end
end
