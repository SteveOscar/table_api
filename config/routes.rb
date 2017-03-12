Rails.application.routes.draw do
  resources :users do
      collection do
        post 'confirm'
        post 'login'
      end
  end
  resources :restaurants
  resources :tables
  post "nearbytables", to: "tables#nearby_tables"
  get "userlogin", to: "users#show"
end
