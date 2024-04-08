Rails.application.routes.draw do
  get 'contact_pages/show'
  get 'about_pages/show'
  get 'users/index'
  get 'users/show'
  get 'genres/index'
  get 'genres/show'
  get 'games/index'
  get 'games/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
