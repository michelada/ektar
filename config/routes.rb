# typed: false
Ektar::Engine.routes.draw do
  root to: "organizations#index"

  resources :organizations
  resources :plans

  resources :users do
    resource :profiles
  end
end
