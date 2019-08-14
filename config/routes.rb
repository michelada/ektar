Ektar::Engine.routes.draw do
  root to: "organizations#index"

  namespace :admin do
    resources :organizations
    resources :users
  end

  resources :organizations do
    resources :users do
      resource :profiles
    end
  end
end
