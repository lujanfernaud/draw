Rails.application.routes.draw do
  root "requests#index"

  resources :requests do
    resource  :random_photo, only: :show
    resources :photos
  end
end
