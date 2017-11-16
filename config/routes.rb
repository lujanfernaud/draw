Rails.application.routes.draw do
  root "requests#index"

  resources :requests do
    resources :photos
  end
end
