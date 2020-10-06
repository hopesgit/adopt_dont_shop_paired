Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/shelters', to: 'shelter#index'
  get 'shelters/:id', to: 'shelter#show'
  get 'shelters/new', to: 'shelter#new'

end
