Rails.application.routes.draw do
  use_doorkeeper
  resources :phone_numbers
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
  	resources :users do 
  	  post :sign_up, on: :collection
  	  post :sign_in, on: :collection
  	  post :add_phone_number, on: :collection
  	end
  end
end
