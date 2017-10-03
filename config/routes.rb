Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :superadmins
  resources :admins
  resources :customers
  resources :cars
  # resources :reservations

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'customers#new'
  post '/signup', to: 'customers#create'

  get '/reserve', to: 'cars#new_reserve'
  post '/reserve', to: 'cars#create_reserve'
  get '/reserve/:id', to: 'cars#show_reserve'
  get '/edit', to: 'cars#edit_reserve'
  post '/edit', to: 'cars#update_reserve'
  get '/reservations', to: 'cars#index_reserve'


  get '/carhistory', to: 'cars#history'
  get '/customer_reservation', to: 'customers#reservation'
  get '/customer_history', to: 'customers#history'
  get '/cancel', to: 'customers#cancel'

  get '/checkout', to: 'cars#checkout'
  get '/returncar', to: 'cars#return_car'

  get '/rent', to: 'cars#new_rent'
  post '/rent', to: 'cars#create_rent'


  # get '/reservation', to: 'reservation#new'
  # post '/reservation', to: 'reservation#reserve' :as => :reservation

end
