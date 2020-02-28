# typed: ignore
Ektar::Engine.routes.draw do
  root to: "select_organization#new"

  resources :sessions, path: I18n.t("routes.session"), only: [:new, :create, :destroy]
  resources :registrations, path: I18n.t("routes.registration"), only: [:new, :create]
  resources :reset_password, path: I18n.t("routes.reset_password"), only: [:new, :create]
  resources :select_organization, path: I18n.t("routes.select_organization"), only: [:new, :create, :update]

  get I18n.t("routes.registration"), to: "registrations#new", as: :new_registrations
  get I18n.t("routes.invitations"), to: "admin/invitations#edit", as: :accept_invitation

  namespace :super_admin do
    root to: "super_admin/organizations#index"

    resources :organizations, path: I18n.t("routes.organizations")
    resources :plans, path: I18n.t("routes.plans")
    resources :users, path: I18n.t("routes.users")
  end

  namespace :admin do
    resources :users, path: I18n.t("routes.users")
    resources :invitations, path: I18n.t("routes.invitations"), only: [:new, :create, :update]
    resources :select_plan, only: [:new, :create]
  end
end
