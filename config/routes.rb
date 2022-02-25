Rails.application.routes.draw do
  resources :gigs
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "gigs#index"
end
