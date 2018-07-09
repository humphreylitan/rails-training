Rails.application.routes.draw do
  get 'landing/index', to: "landing#index"
  root "landing#index"

  resources :posts
  resources :authors, only: :index

end
