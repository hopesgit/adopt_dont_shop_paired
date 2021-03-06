Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'shelters#index'
  get '/shelters', to: 'shelters#index'

  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  get '/shelters/:id/delete', to: 'shelters#destroy'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get 'pets/:id', to: 'pets#show'
  get '/shelters/:id/pets', to: 'shelter_pets#index'
  get '/shelters/:id/pets/new', to: 'pets#new'
  post '/shelters/:id/pets', to: 'pets#create'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  get '/pets/:id/delete', to: 'pets#destroy'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'reviews#create'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#destroy'

  get '/users/new', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id', to: 'users#show'

  get '/applications', to: 'applications#index'
  get '/applications/new', to: 'applications#new'
  post '/applications', to: 'applications#create'
  get '/applications/:id', to: 'applications#show'
  get '/applications/:id/edit', to: 'applications#edit'
  patch '/applications/:id', to: 'applications#update'

  get '/admin/applications/:id', to: 'admin_applications#show'
  patch '/admin/applications/:id/:pet_id', to: 'application_pets#update'

  get '/pets/:pet_id/applications', to: 'application_pets#index'
end
