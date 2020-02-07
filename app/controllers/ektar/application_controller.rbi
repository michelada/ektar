# typed: strong
module Ektar
  module ApplicationHelper
    def model_name; end
  end

  class ApplicationController < ActionController::Base
    extend T::Sig
    include ApplicationHelper

    sig { params(klasses: T::Array[Class], with: Symbol).void }
    def rescue_from(*klasses, with:); end

    sig { returns(T.untyped) }
    def cookies; end

    def index!; end

    def show!; end
    
    def new!; end
    
    sig{ params(before_save: T.proc.params(arg0: T.untyped).returns(T.untyped)).void }
    def create!(before_save:); end
    
    def edit!; end
    
    sig{ params(before_save: T.proc.params(arg0: T.untyped).returns(T.untyped)).void }
    def update!(before_save:); end
    
    def destroy!; end
  end

  class UsersController < Ektar::ResourcefulController
    include ActionDispatch::Cookies::ChainedCookieJars
  end
end

