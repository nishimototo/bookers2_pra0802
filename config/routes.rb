Rails.application.routes.draw do


  devise_for :users

  root "homes#top"
  get "home/about" => "homes#about"
  get "search" => "searches#search"
  get "chats/:id" => "chats#show", as:"chat"
  get "book_search" => "homes#book_search"

  resources :users do
    get "search_book" => "users#search_book"

    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :chats, only: [:create]
  resources :groups do
    get "join" => "groups#join"
  end
end
