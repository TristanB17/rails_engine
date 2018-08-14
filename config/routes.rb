Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        resources :search, only: [:index]
        resources :search_all, only: [:index]
        resources :random, only: [:index]
      end
      resources :invoices, only: [:index, :show]
    end
  end
end
