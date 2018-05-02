Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find',     to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random',   to: 'random#show'
      end
      namespace :invoices do
        get '/find',        to: 'find#show'
        get '/find_all',    to: 'find#index'
        get '/random',      to: 'random#show'
        get ':id/merchant', to: 'merchant#index'
      end
      namespace :transactions do
        get '/find',     to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random',   to: 'random#show'
      end
      resources :merchants, only: %i[index show]
      resources :transactions, only: %i[index show]
      resources :invoices, only: [:index, :show]
    end
  end
end
