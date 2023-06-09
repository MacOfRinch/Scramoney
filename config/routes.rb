Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#top"

  resources :families do
    resources :users, only: %i[new create show edit update destroy]
    resources :tasks do
      get 'menu', on: :collection
      post :task_users, to: 'task_users#create', on: :member
      delete :task_users, to: 'task_users#destroy', on: :member
    end
    resources :task_users, only: %i[create destroy]
    resources :notices, only: %i[index show]
    resources :records do
      get :task_show, on: :member
    end
    get :configuration
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  # Defines the root path route ("/")
  # root "articles#index"
end
