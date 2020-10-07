Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'shelters#index'
  get '/shelters', to: 'shelters#index'

  # get '/shelters/:id', to: 'shelter#show'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'

end
