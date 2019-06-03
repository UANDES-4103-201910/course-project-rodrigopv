Rails.application.routes.draw do
  devise_for :users, controllers: {
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # devise_for :users

  resources :users
  resources :complaints do
    resources :comments
    resources :likes
  end
  resources :comments
  
  get '/admin', to: 'admin#index'

  root to: 'homepage#index'
  get '/', to: 'homepage#index'
  get '/login', to: 'homepage#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
