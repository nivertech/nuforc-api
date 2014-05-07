UfoApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sightings, only: [:index, :show]
      resources :months, only: [:index, :show]

      get ':year', to: 'months#year'
      get ':year/:month', to: 'months#month'

      get ':year/:month/:day', to: 'sightings#day'
    end
  end
end
