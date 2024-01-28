Rails.application.routes.draw do
	get 'admin/billing', to: 'page#billing'
	get 'admin/notifications', to: 'page#notifications'
	get 'admin/settings', to: 'page#settings'
	get 'admin/profile', to: 'page#profile'
	get 'admin/project', to: 'page#project'
	get 'admin/projects', to: 'page#projects'
	get 'admin/dashboard', to: 'page#dashboard'
	get 'pricing', to: 'page#pricing' 
	get 'about', to: 'page#about'

  root "home#index"

  if Rails.env.development? || Rails.env.test?
    mount Railsui::Engine, at: "/railsui"
  end

  # Inherits from Railsui::PageController#index
  # To overide, add your own page#index view or change to a new root
  # Visit the start page for Rails UI any time at /railsui/start

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get 'dashboard', to: 'dashboard#index'

  resource :products, only: %i[index edit new create] do
    resources :contents, only: :index, controller: 'products/contents'
    resources :attach_contents, only: :create, controller: 'products/attach_contents'
  end

  scope module: :products, path: :products, as: :product do
    resources :publish, only: :update
    resources :unpublish, only: :update
  end

  namespace :api do
    resources :contents, only: [:create, :update, :delete]
  end
end
