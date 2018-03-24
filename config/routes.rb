Rails.application.routes.draw do
  resources :links
  get ':slug' => 'links#show'
  get '/all' => 'home#all'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
