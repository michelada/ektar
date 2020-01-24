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
