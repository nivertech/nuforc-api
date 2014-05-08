UfoApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do      
      get 'all', to: 'sightings#index'
      
      get ':year', to: 'sightings#year'
      get ':year/:month', to: 'sightings#month'
      get ':year/:month/:day', to: 'sightings#day'

      get ':city', to: 'sightings#city'
    end
  end
end
