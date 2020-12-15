# typed: ignore

module Ektar
  class SuperAdmin::ApplicationController < ResourcefulController
    extend T::Sig

    sig { returns(String) }
    def new_resource_path
      path = "new_super_admin_#{resource_class.model_name.singular_route_key}_path"
      ektar.send(path)
    end

    sig { params(resource: ActiveRecord::Base).returns(String) }
    def edit_resource_path(resource)
      path = "edit_super_admin_#{resource.model_name.singular_route_key}_path"
      ektar.send(path, resource)
    end

    sig { params(resource: ActiveRecord::Base).returns(String) }
    def resource_path(resource)
      path = "super_admin_#{resource.model_name.singular_route_key}_path"
      ektar.send(path, resource)
    end

    sig { returns(String) }
    def collection_path
      ektar.send("super_admin_#{resource_class.model_name.route_key}_path")
    end
  end
end
