# typed: ignore
Ektar::Engine.routes.draw do
  root to: "organizations#index"

  resources :organizations, path: I18n.t("routes.organizations")
  resources :plans, path: I18n.t("routes.plans")
  resources :users, path: I18n.t("routes.users")

  resources :sessions, path: I18n.t("routes.session"), only: [:new, :create, :destroy]
  resources :invitations, path: I18n.t("routes.invitations"), only: [:new, :create]
  resources :registrations, path: I18n.t("routes.registration"), only: [:new, :create]

  resources :select_organization, only: [:create]

  get I18n.t("routes.registration"), to: "registrations#new", as: :new_registrations
end
