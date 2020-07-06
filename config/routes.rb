# typed: ignore
# frozen_string_literal: true

Ektar::Engine.routes.draw do
  root to: "select_organization#new"

  resource :sessions, path: I18n.t("routes.session"), only: [:new, :create, :destroy]
  resources :registrations, path: I18n.t("routes.registration"), only: [:new, :create]
  resources :select_organization, path: I18n.t("routes.select_organization"), only: [:new, :create, :update]

  get I18n.t("routes.reset_password"), to: "reset_passwords#new", as: :new_reset_password
  post I18n.t("routes.reset_password"), to: "reset_passwords#create", as: :reset_password

  get I18n.t("routes.password"), to: "passwords#edit", as: :edit_passwords
  patch I18n.t("routes.password"), to: "passwords#update", as: :passwords

  get I18n.t("routes.registration"), to: "registrations#new", as: :new_registrations
  get I18n.t("routes.accept_invitation"), to: "accept_invitations#new", as: :accept_invitations

  namespace :super_admin do
    root to: "super_admin/organizations#index"

    resources :organizations, path: I18n.t("routes.organizations")
    resources :plans, path: I18n.t("routes.plans")
    resources :users, path: I18n.t("routes.users")
  end

  namespace :admin do
    resources :users, path: I18n.t("routes.users"), only: [:new, :index, :destroy]
    resources :invitations, path: I18n.t("routes.invitations"), only: [:new, :create]
    resources :select_plan, only: [:new, :create]
  end
end
