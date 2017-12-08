Rails.application.routes.draw do
  root "requests#index"

  resources :requests, only: :index do
    resource  :random_photo, only: :show
    resources :photos, only: [:index, :show]
  end
end
