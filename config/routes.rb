# typed: ignore
Ektar::Engine.routes.draw do
  root to: "organizations#index"

  resources :organizations, path: I18n.t("routes.organizations")
  resources :plans, path: I18n.t("routes.plans")

  get I18n.t("routes.registration"), to: "users#new", as: :registration
  resources :users, path: I18n.t("routes.users")
end
