# typed: strong
module Ektar
  module ApplicationHelper
    def model_name; end
  end
end

module Ektar
  class ApplicationController < ActionController::Base
    include ApplicationHelper
  end
end

module ActionDispatch::Cookies::ChainedCookieJars
  def cookies
  end
end

module Ektar
  class UsersController < ResourcefulController
    include ActionDispatch::Cookies::ChainedCookieJars
  end
end
