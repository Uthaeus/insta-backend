Rails.application.routes.draw do
  resources :comments
  resources :posts
  get 'home', to: 'pages#home'
  get 'user_current', to: 'pages#user_current'
  
  devise_for :users, controllers: { 
    registrations: 'users/registrations', sessions: 'users/sessions' 
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
