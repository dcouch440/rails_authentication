Rails.application.routes.draw do
  root 'homes#index'

  resources :users, only: [:create, :show]

  get '/signup' => 'users#new'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

end
