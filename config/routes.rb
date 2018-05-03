Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find',     to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random',   to: 'random#show'
      end
      namespace :invoices do
        get '/find',            to: 'find#show'
        get '/find_all',        to: 'find#index'
        get '/random',          to: 'random#show'
        get ':id/merchant',     to: 'merchant#index'
        get ':id/customer',     to: 'customer#index'
        get ':id/transactions', to: 'transactions#index'
        get ':id/items',        to: 'items#index'
      end
      namespace :items do
        get '/find',        to: 'find#show'
        get '/find_all',    to: 'find#index'
        get '/random',      to: 'random#show'
      end
      namespace :merchants do
        get '/find',     to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random',   to: 'random#show'
      end
      namespace :transactions do
        get '/find',     to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random',   to: 'random#show'
      end
      resources :customers,    only: %i[index show]
      resources :invoices,     only: %i[index show]
      resources :items,        only: %i[index show]
      resources :merchants,    only: %i[index show]
      resources :transactions, only: %i[index show]
    end
  end
end
