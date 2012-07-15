InventoryManagement::Application.routes.draw do
#  get "user_sessions/new"
#  resources :user_sessions

  resources :users 
#  resources :sessions, only: [:new,:create,:destroy]
  root :to => "home#index"
  match '/signup',  to: 'users#new' 
  match '/signin',  to: 'user_sessions#new'
  match '/signout', to: 'user_sessions#destroy', via: :delete

  resources :user_sessions

end
