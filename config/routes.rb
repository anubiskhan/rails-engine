Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find',                  to: 'find#show'
        get '/find_all',              to: 'find#index'
        get '/random',                to: 'random#show'
        get '/:id/invoices',          to: 'invoices#index'
        get '/:id/transactions',      to: 'transactions#index'
        get '/:id/favorite_merchant', to: 'favorite_merchant#show'
      end
      namespace :items do
        get '/find',              to: 'find#show'
        get '/find_all',          to: 'find#index'
        get '/random',            to: 'random#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant',      to: 'merchant#show'
        get '/most_revenue',      to: 'most_revenue#show'
        get '/most_items',        to: 'most_items#show'
        get '/:id/best_day',      to: 'best_day#show'
      end
      namespace :invoices do
        get '/find',             to: 'find#show'
        get '/find_all',         to: 'find#index'
        get '/random',           to: 'random#show'
        get '/:id/merchant',      to: 'merchant#index'
        get '/:id/customer',      to: 'customer#index'
        get '/:id/transactions',  to: 'transactions#index'
        get '/:id/items',         to: 'items#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
      end
      namespace :invoice_items do
        get '/find',        to: 'find#show'
        get '/find_all',    to: 'find#index'
        get '/random',      to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item',    to: 'item#show'
      end
      namespace :items do
        get '/find',              to: 'find#show'
        get '/find_all',          to: 'find#index'
        get '/random',            to: 'random#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant',      to: 'merchant#show'
        get '/most_revenue',      to: 'most_revenue#show'
        get '/most_items',        to: 'most_items#show'
        get '/:id/best_day',      to: 'best_day#show'
      end
      namespace :merchants do
        get '/find',                            to: 'find#show'
        get '/find_all',                        to: 'find#index'
        get '/random',                          to: 'random#show'
        get '/:id/invoices',                    to: 'invoices#index'
        get '/:id/items',                       to: 'items#index'
        get '/:id/favorite_customer',           to: 'customer#show'
        get '/revenue',                         to: 'revenue#index'
        get '/:id/revenue',                     to: 'revenue#show'
        get '/most_revenue',                    to: 'most_revenue#show'
        get '/most_items',                      to: 'most_items#index'
        get '/:id/customers_with_pending_invoices', to: 'customer#index'
      end
      namespace :transactions do
        get '/find',        to: 'find#show'
        get '/find_all',    to: 'find#index'
        get '/random',      to: 'random#show'
        get '/:id/invoice', to: 'invoice#show'
      end
      resources :customers,     only: %i[index show]
      resources :invoices,      only: %i[index show]
      resources :invoice_items, only: %i[index show]
      resources :items,         only: %i[index show]
      resources :merchants,     only: %i[index show]
      resources :transactions,  only: %i[index show]
    end
  end
end
