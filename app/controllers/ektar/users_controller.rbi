# typed: strong

module ActionDispatch::Cookies::ChainedCookieJars
  def cookies
  end
end

module Ektar
  class UsersController < ResourcefulController
    include ActionDispatch::Cookies::ChainedCookieJars
  end
end

class ActionController::Parameters
  def first
  end
end
