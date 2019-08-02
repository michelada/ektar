module Ektar
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout "ektar/application"

    def collection
      @collection ||= model_name.all
    end

    def resource
      @resource ||= model_name.new
    end
    helper_method :collection, :resource
  end
end
