Ektar::Engine.routes.draw do
  resources :organizations, only: %i[show update] do
    resources :users

    namespace :user do
      resources :profile
    end
  end
end
