UfoApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sightings, only: [:index, :show]
      resources :months, only: [:index, :show]
    end
  end
end
