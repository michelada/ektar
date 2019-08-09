Ektar::Engine.routes.draw do
  
  resources :organizations
  resources :users do
    resource :profile
  end
end
