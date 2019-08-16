Ektar::Engine.routes.draw do
  root to: "organizations#index"

  resources :organizations do
    resources :users do
      resource :profiles
    end
  end
end
