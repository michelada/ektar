# typed: false
# frozen_string_literal: true

load Ektar::Engine.root.join("app", "controllers", "ektar", "sessions_controller.rb")
Ektar::SessionsController.class_eval do

  # sig { returns(String) }
  # def after_sign_in_path
  #   super
  # end
end
