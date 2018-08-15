Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        resources :search, only: [:index]
        resources :search_all, only: [:index]
        resources :random, only: [:index]
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items', to: 'items#index'
        get '/:id/customer', to: 'customer#index'
        get '/:id/merchant', to: 'merchant#index'
      end
      resources :invoices, only: [:index, :show]
      namespace :merchants do
        resources :most_revenue, only: [:index]
        resources :random, only: [:index]
        resources :find_all, only: [:index]
        resources :find, only: [:index]
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/customers', to: 'customers#index'
      end
      resources :merchants, only: [:show, :index]
    end
  end
end
