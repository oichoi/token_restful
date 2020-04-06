Rails.application.routes.draw do
  get '/products/search', to: 'products#search'
  post '/products/update', to: 'products#update'
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
