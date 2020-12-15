# typed: ignore
# frozen_string_literal: true

require "pathname"

module Ektar
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def create_initializer
        template "initializer.rb", "config/initializers/ektar.rb"
      end

      def create_migrations
        rails_command "railties:install:migrations", inline: true
      end

      def add_routes
        insert_into_file "config/routes.rb", after: /Rails\.application\.routes\.draw do/ do
          <<~ROUTES

            # Ektar routes
            get "/login", to: "ektar/sessions#new", as: :sign_in
            post "/login", to: "ektar/sessions#create", as: :sign_in_create

            get "/signup", to: "ektar/registrations#new", as: :sign_up
            post "/signup", to: "ektar/registrations#create", as: :sign_up_create

            get "/reset_password", to: "ektar/reset_password#new", as: :reset_password
            post "/reset_password", to: "ektar/reset_password#create", as: :reset_password_create

            mount Ektar::Engine => "/ektar"
          ROUTES
        end
      end

      def change_application_controller
        gsub_file "app/controllers/application_controller.rb", /ActionController::Base/, "Ektar::ApplicationController"
      end

      def copy_templates
        copy_file "#{GEM_ROOT}/app/views/layouts/ektar/users.html.erb", "app/views/layouts/ektar/users.html.erb"
        copy_file "#{GEM_ROOT}/app/views/ektar/sessions/new.html.erb", "app/views/ektar/sessions/new.html.erb"
        copy_file "#{GEM_ROOT}/app/views/ektar/registrations/new.html.erb", "app/views/ektar/registrations/new.html.erb"
        copy_file "#{GEM_ROOT}/config/locales/es.yml", "config/locales/es.yml"
      end

      def create_files
        template "user.rb", "app/models/ektar/user.rb"
        template "sessions_controller.rb", "app/controllers/ektar/sessions_controller.rb"
        template "registrations_controller.rb", "app/controllers/ektar/registrations_controller.rb"
      end

      def display_info
        say <<~INFO, :green

          INFO: Modify ektar initializer according to your application.
          You can find the initializer here: config/initializers/ektar.rb

          Remember to create Super Admin users after migrations. Also, add
          one or many plans by login in to /ektar/plans
        INFO
      end

      private

      GEM_ROOT = "#{__dir__}/../../../.."
    end
  end
end
