# frozen_string_literal: true

ActiveAdmin.register Genre do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name
  filter :games_id_eq, as: :select, collection: -> { Game.all.map { |game| [game.title, game.id] } }
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs 'Genre Details' do
      f.input :name
    end
    f.actions
  end
end
