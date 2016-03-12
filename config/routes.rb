Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  namespace :api do
    namespace :v1, defaults: {format: 'json'} do
      # resources :products, only: [:index, :show]
      # resources :categories, only: [:index]
      resources :orders, only: [:create]

      # get 'bot/listen' => 'bots#listen'
      post 'bot/update' => 'bots#update'
    end
  end

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
