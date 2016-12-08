Rails.application.routes.draw do

  namespace :admin do
    resources :words, only: :index
    resources :users, except: [:new, :create, :show]
    resources :categories do
      resources :words, except: :show
    end
  end

  root  "static_pages#home"
  get "contact" =>  "static_pages#contact"
  get "login" =>  "sessions#new"
  post "login" =>  "sessions#create"
  delete "logout" =>  "sessions#destroy"
  get "signup" => "users#new"

  resources :users
  resources :categories, only: :index
  resources :words, only: :index
end
