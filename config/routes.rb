Rails.application.routes.draw do
  root "requests#index"

  resources :requests, path: "", only: :index do
    resource  :random_photo, only: :show
    resources :photos, path: "", only: [:index, :show]
  end
end
