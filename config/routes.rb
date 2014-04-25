UfoApi::Application.routes.draw do
  resources :sightings, only: [:index, :show]
  resources :months, only: [:index, :show]
end
