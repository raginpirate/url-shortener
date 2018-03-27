Rails.application.routes.draw do
  # enabled only /slug, /, and /links/slug
  # all other urls direct to home#error
  get "home/index"
  get '/all' => 'home#all'
  get ':slug' => 'links#show'
  resources :links
  get '/links' => 'links#show'
  get '*path' => 'home#error'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
