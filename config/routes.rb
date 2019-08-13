Ektar::Engine.routes.draw do
  resources :organizations do
    resources :users do
      resource :profiles
    end
  end
end
