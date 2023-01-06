Rails.application.routes.draw do
  resources :urls
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope module: 'api', path: 'api' do
    namespace :v1 do
      resources :urls
      post 'urls/encode', to: 'urls#encode'
      post 'urls/decode', to: 'urls#decode'
    end
  end
end
