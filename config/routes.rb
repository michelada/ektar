Ektar::Engine.routes.draw do
  resources :organizations, only: [:index, :new]
end
