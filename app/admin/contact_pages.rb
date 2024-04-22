# frozen_string_literal: true

ActiveAdmin.register ContactPage do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :context
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :context]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs 'Contact Page' do
      f.input :title
      f.input :context
    end
    f.actions
  end
end
