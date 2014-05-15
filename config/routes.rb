UfoApi::Application.routes.draw do
  namespace :api do
    namespace :v1 do      
      get 'all', to: 'sightings#index'
      get 'latest', to: 'sightings#current_month'
      
      get 'date/:year', to: 'sightings#year'
      get 'date/:year/:month', to: 'sightings#month'
      get 'date/:year/:month/:day', to: 'sightings#day'

      # for birthdays
      get 'birthday/:month/:day', to: 'sightings#birthday'

      get 'location/:state', to: 'sightings#state'
      get 'location/:state/:city', to: 'sightings#city'
    end
  end
end
