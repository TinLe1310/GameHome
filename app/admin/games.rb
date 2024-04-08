ActiveAdmin.register Game do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :release_date, :official_store_price, :key_store_price, genre_ids: []
  filter :genres_id_eq, as: :select, collection: -> { Genre.all.map { |genre| [genre.name, genre.id] } }
  remove_filter :image_attachment, :image_blob
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :release_date, :official_store_price, :key_store_price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ""
      f.input :genres, as: :check_boxes
    end
    f.actions
  end

end
