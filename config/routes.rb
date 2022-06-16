Rails.application.routes.draw do
  root to: "games#index"

  resources :games do
    resources :moves, only: [:create]
  end
end
