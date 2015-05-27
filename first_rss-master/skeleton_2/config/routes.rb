NewsReader::Application.routes.draw do
  namespace :api do
    resources :feeds, only: [:index, :create, :show, :destroy] do
      resources :entries, only: [:index, :destroy]
    end
  end

  root to: "static_pages#index"
end
