Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  devise_for :users
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get 'followings' => 'relationships#followings', as:'followings'
      get 'followers' => 'relationships#followers', as:'followers'
    end
  end

  get 'search' => 'searches#search', as:'search'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
