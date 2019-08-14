module Ektar
  module Admin
    class AdminController < ApplicationController
      before_action :authorized?

      private 

      def authorize
        authenticate_or_request_with_http_basic("Restricted Access") do |username, password|
          return session[:admin] = true if username == 'superadmin' && password == 'superadmin123'

          session[:admin] = false

        end
        # authenticate_or_request_with_http_basic do |user, password|
        #   return session[:admin] = true if validate_pass(user, password)

        #   session[:admin] = false
        #   redirect_to root_path
        # end
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
