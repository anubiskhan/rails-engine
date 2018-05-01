Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: %i[new edit]
      namespace :invoices do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
      resources :invoices, only: [:index, :show]
    end
  end
end
