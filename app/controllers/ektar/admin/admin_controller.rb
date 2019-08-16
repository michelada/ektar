# frozen_string_literal: true

require_dependency "ektar/application_controller"

module Ektar
  module Admin
    class AdminController < ApplicationController
      before_action :authorized?
      layout 'ektar/admin/application'

      private 
      def authorize
        authenticate_or_request_with_http_basic("Restricted Access") do |username, password|
          return session[:admin] = true if username == 'superadmin' && password == 'superadmin123'

          session[:admin] = false
        end
      end

      def authorized?
        return if session[:admin] == true
        authorize
      end

      def validate_pass(user, password)
        user == 'superadmin' && password == 'superadmin123'
      end
    end
  end
end
