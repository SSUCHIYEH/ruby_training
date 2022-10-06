Rails.application.routes.draw do
  get 'admin/users'
  resources :tasks
  # SESSION
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # USER
  get 'sign_up', to: 'users#new'
  resources :users, only: [:create]
  # ADMIN
  namespace :admin do
    get '', to: 'users#index', as: '/'
    get 'user/:id/tasks', to: 'users#tasks', as: 'user_tasks'
    resources :users
  end
  root to: "tasks#index"
end
