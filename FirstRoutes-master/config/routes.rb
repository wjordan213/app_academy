Rails.application.routes.draw do
  resources :users, only: [ :index, :create, :destroy, :show, :update ] do
    resources :contacts, only: [ :index ]
  end

  resources :contacts, only: [ :create, :destroy, :show, :update]

  # get 'users/:id/contacts' to: 'contacts#index'


  # get 'users',          to: 'users#index'
  # post 'users',         to: 'users#create'
  # get 'users/new' => 'users#new', :as => 'new_user'
  # get 'users/:id/edit' => 'users#edit', :as=> 'edit_user'
  # get 'users/:id' => 'users#show', :as => 'user'
  # patch 'users/:id',    to: 'users#update'
  # put 'users/:id',      to: 'users#update'
  # delete 'users/:id',   to: 'users#destroy'
end
