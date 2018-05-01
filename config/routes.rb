Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: %i[new edit]
      resources :invoices, only: [:index]
    end
  end
end
