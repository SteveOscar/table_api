Rails.application.routes.draw do
  resources :users
  resources :restaurants
  resources :tables
  post "nearbytables", to: "tables#nearby_tables"
end
