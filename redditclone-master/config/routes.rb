Rails.application.routes.draw do
  resources :users, except: [:index]
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :subs, except: [:destroy]

  resources :posts, only: [ :show, :new, :create, :edit, :update ] do
    resources :comments, only: [ :new ]
  end

  resources :comments, only: [ :create, :show ]
end
