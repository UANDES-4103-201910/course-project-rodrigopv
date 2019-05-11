Rails.application.routes.draw do
  resources :users
  resources :complaints

  get '/', to: 'homepage#index'
  get '/login', to: 'homepage#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
