Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'edit',  to: 'users#edit'

  resources :users do#usersこんとろーらにfollowingsアクションとルートを設定する
    member do
      get 'followings'
      get 'followered'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts

  resources :relationships, only: [:create, :destroy]
end