NinetyNineCats::Application.routes.draw do
  resources :users, only: [ :create, :show, :index, :new]
  resources :cats, only: [ :index, :show, :new, :create, :edit, :update, :destroy]

  resources :cat_rental_requests, only: [ :new, :create]
    root to: 'cats#index'



   patch 'cat_rental_requests/:id/deny', :to => 'cat_rental_requests#deny', as: 'cat_rental_deny'
   patch 'cat_rental_requests/:id/approve', :to => 'cat_rental_requests#approve', as: 'cat_rental_approve'



   get 'session', :to => 'sessions#new', as: 'login'
   post 'session', to: 'sessions#create'
   delete 'session', :to => 'sessions#destroy'

end
