# typed: ignore
Ektar::Engine.routes.draw do
  root to: "organizations#index"

  resources :organizations
  resources :plans

  resources :users
end
