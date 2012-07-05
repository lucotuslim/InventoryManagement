InventoryManagement::Application.routes.draw do
  resources :users 

  root :to => "home#index"
  match '/signup',  to: 'users#new'
end
