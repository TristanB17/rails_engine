Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :random, only: [:index]
        resources :find_all, only: [:index]
        resources :find, only: [:index]
      end
      resources :merchants, only: [:show, :index]
    end
  end
end
