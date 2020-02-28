# typed: false
# frozen_string_literal: true

module Ektar
  class Admin::BaseController < ResourcefulController
    extend T::Sig

    before_action :authenticate_admin!

    private

    def authenticate_admin!
      redirect_to(ektar_url_helpers.new_session_path, alert: t("flash.session.authenticate!")) && return unless user_signed_in?
      redirect_to Ektar.configuration.root_app_path unless current_user&.admin?
    end

    sig { returns(String) }
    def new_resource_path
      ektar_url_helpers.send "new_admin_#{resource_class.model_name.singular_route_key}_path"
    end

    sig { params(resource: ActiveRecord::Base).returns(String) }
    def edit_resource_path(resource)
      ektar_url_helpers.send("edit_admin_#{resource.model_name.singular_route_key}_path", resource)
    end

    sig { params(resource: ActiveRecord::Base).returns(String) }
    def resource_path(resource)
      ektar_url_helpers.send("admin_#{resource.model_name.singular_route_key}_path", resource)
    end

    sig { returns(String) }
    def collection_path
      ektar_url_helpers.send "admin_#{resource_class.model_name.route_key}_path"
    end
  end
end
