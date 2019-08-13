Ektar::Engine.routes.draw do
  resources :organizations do
    resources :users do
      resource :profile
    end
  end
end
