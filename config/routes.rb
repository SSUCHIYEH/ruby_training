Rails.application.routes.draw do
  resources :tasks
  # SESSION
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # USER
  get 'sign_up', to: 'users#new'
  resources :users, only: [:new, :create]
  # ADMIN
  get 'admin', to: 'admin#index'
  post 'admin', to: 'admin#create', as: 'admin_create_user'
  delete 'admin', to: 'admin#destroy', as: 'admin_delete_user'
  patch 'admin', to: 'admin#update', as: 'admin_update_user'
  get 'admin/new', to: 'admin#new', as: 'admin_new_user'
  get 'admin/tasks/:id', to: 'admin#user_tasks', as: 'admin_user_tasks'
  get 'admin/edit/:id', to: 'admin#edit', as: 'admin_edit_user'
  root to: "tasks#index"
end
