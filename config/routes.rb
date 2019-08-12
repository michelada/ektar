Ektar::Engine.routes.draw do
  resources :organizations
  resources :users
  resources :profiles, except: :index
end
