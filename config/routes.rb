UfoApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do      
      get 'all', to: 'sightings#index'
      get 'latest', to: 'sightings#current_month'
      
      get ':year', to: 'sightings#year'
      get ':year/:month', to: 'sightings#month'
      get ':year/:month/:day', to: 'sightings#day'

      get ':state', to: 'sightings#state'
      get ':state/:city', to: 'sightings#city'
    end
  end
end
