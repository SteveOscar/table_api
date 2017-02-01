Rails.application.routes.draw do
  resources :users
  post "nearbytables", to: "tables#nearby_tables"
end
