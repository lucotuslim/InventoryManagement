InventoryManagement::Application.routes.draw do
  get "users/new"

  root :to => "home#index"
end
