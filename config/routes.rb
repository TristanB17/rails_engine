Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :invoices, only: [:index, :show]
      namespace :invoices do
        resources :find, only: [:index]
        resources :find_all, only: [:index]
        resources :random, only: [:index]
      end
    end
  end
end
