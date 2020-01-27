require_dependency "ektar/application_controller"

module Ektar
  class SessionsController < ApplicationController
    def new
      @user = Ektar::User.find_by[:user_id]
    end

    def destroy
    end
  end
end
