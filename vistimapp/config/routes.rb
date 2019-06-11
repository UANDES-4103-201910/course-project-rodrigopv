Rails.application.routes.draw do
  devise_for :users, controllers: {
        registrations: 'users/registrations',
        omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # devise_for :users

  resources :users do
       get  :restore
       get  :blacklist
       post :changepassword
  end
  resources :complaints do
    resources :comments
    member do
       post :like
       post :dislike
       post :follow
       post :unfollow
       get  :republish
       get  :unpublish
       get  :addmedia, to: 'complaints#uploadmedia'
       post :addmedia, to: 'complaints#addmedia'
    end
  end
  resources :comments
  
  get '/admin', to: 'admin#index'
  get '/admin/dumpster'
  get '/admin/blacklist'
  get '/admin/users'

  get '/aup', to: 'homepage#aup'
  get '/tos', to: 'homepage#tos'

  root to: 'homepage#index'
  get '/', to: 'homepage#index'
  get '/login', to: 'homepage#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
