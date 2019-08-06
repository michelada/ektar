Ektar::Engine.routes.draw do
  resources :organizations#, except: :show
end
