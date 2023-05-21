Rails.application.routes.draw do
  resources :likes
  resources :topics
  resources :comments do
    resources :likes, only: [:create, :destroy]

    resources :comments do 
      resources :likes, only: [:create, :destroy]
    end
  end
  resources :posts do
    resources :likes, only: [:create, :destroy]

    resources :comments do 
      resources :likes, only: [:create, :destroy]
    end
  end

  get 'home', to: 'pages#home'
  get 'user_current', to: 'pages#user_current'
  
  devise_for :users, controllers: { 
    registrations: 'users/registrations', sessions: 'users/sessions' 
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
