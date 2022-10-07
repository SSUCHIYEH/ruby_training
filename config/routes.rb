Rails.application.routes.draw do
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
    get '/', to: 'users#index', as: '/'
    # get 'user/:id/tasks', to: 'users#tasks', as: 'user_tasks'
    resources :users do
      member do
        get 'tasks'
      end
    end
  end
  root to: "tasks#index"
end
