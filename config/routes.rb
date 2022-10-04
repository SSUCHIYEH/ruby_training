Rails.application.routes.draw do
  resources :tasks
  # SESSION
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # USER
  get 'sign_up', to: 'users#new'
  resources :users, except: [:new]
  root to: "sessions#new"
end
