Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        resources :find, only: [:index]
        resources :find_all, only: [:index]
        resources :random, only: [:index]
        get '/:id/transactions', to: 'transactions#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/items', to: 'items#index'
        get '/:id/customer', to: 'customer#index'
        get '/:id/merchant', to: 'merchant#index'
      end
      resources :invoices, only: [:index, :show]
      namespace :merchants do
        resources :most_items, only: [:index]
        resources :most_revenue, only: [:index]
        resources :random, only: [:index]
        resources :find_all, only: [:index]
        resources :find, only: [:index]
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/customers', to: 'customers#index'
        get '/:id/items', to: 'items#index'
        get '/:id/revenue', to: 'revenue#index'
        get '/revenue', to: 'date_revenue#index'
      end
      resources :merchants, only: [:show, :index]
      namespace :items do
        resources :find, only: [:index]
        resources :find_all, only: [:index]
        resources :random, only: [:index]
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchant#index'
        get '/most_revenue', to: 'revenue#index'
      end
      resources :items, only: [:index, :show]
      namespace :invoice_items do
        resources :find, only: [:index]
        resources :find_all, only: [:index]
        resources :random, only: [:index]
        get '/:id/invoice', to: 'invoice#index'
        get '/:id/item', to: 'item#index'
      end
      resources :invoice_items, only: [:index, :show]
      namespace :transactions do
        resources :random, only: [:index]
        resources :find_all, only: [:index]
        resources :find, only: [:index]
        get '/:id/invoice', to: 'invoice#index'
      end
      resources :transactions, only: [:show, :index]
      namespace :customers do
        resources :random, only: [:index]
        resources :find_all, only: [:index]
        resources :find, only: [:index]
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end
      resources :customers, only: [:index, :show]
    end
  end
end
