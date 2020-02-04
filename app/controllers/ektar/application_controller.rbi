# typed: strong
module Ektar
  module ApplicationHelper
    def model_name; end
  end

  class ApplicationController < ActionController::Base
    include ApplicationHelper
    
    def cookies
    end
  end

  class UsersController < ResourcefulController
    include ActionDispatch::Cookies::ChainedCookieJars
  end
end

