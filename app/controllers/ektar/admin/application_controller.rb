# typed: false
# frozen_string_literal: true

module Ektar
  class Admin::ApplicationController < ResourcefulController
    include Pagy::Backend
    extend T::Sig

    before_action :authenticate_admin!

    private

    def signed_in_admin_user?
      return false if current_organization.nil?
      @signed_in_admin_user ||= current_user.memberships
        .detect { |membership| membership.ektar_organization_id == current_organization.id && membership.role == "admin" }
        .present?
    end
    helper_method :signed_in_admin_user?

    def authenticate_admin!
      redirect_to(Ektar.configuration.sign_in_path || ektar.new_session_path, alert: t("flash.session.authenticate!")) && return unless user_signed_in?
      redirect_to Ektar.configuration.root_app_path unless signed_in_admin_user?
    end
  end
end
