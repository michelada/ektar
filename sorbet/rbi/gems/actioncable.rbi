# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strong
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/actioncable/all/actioncable.rbi
#
# actioncable-6.0.3.1

module ActionCable
  def self.gem_version; end
  def self.server; end
  def self.version; end
  def server; end
  extend ActiveSupport::Autoload
end
module ActionCable::VERSION
end
module ActionCable::Helpers
end
module ActionCable::Helpers::ActionCableHelper
  def action_cable_meta_tag; end
end
class ActionCable::Engine < Rails::Engine
end
module ActionCable::Channel
  extend ActiveSupport::Autoload
end
module ActionCable::Channel::Callbacks
  extend ActiveSupport::Concern
  include ActiveSupport::Callbacks
end
module ActionCable::Channel::Callbacks::ClassMethods
  def after_subscribe(*methods, &block); end
  def after_unsubscribe(*methods, &block); end
  def before_subscribe(*methods, &block); end
  def before_unsubscribe(*methods, &block); end
  def on_subscribe(*methods, &block); end
  def on_unsubscribe(*methods, &block); end
end
module ActionCable::Channel::PeriodicTimers
  def active_periodic_timers; end
  def start_periodic_timer(callback, every:); end
  def start_periodic_timers; end
  def stop_periodic_timers; end
  extend ActiveSupport::Concern
end
module ActionCable::Channel::PeriodicTimers::ClassMethods
  def periodically(callback_or_method_name = nil, every:, &block); end
end
module ActionCable::Channel::Streams
  def default_stream_handler(broadcasting, coder:); end
  def identity_handler; end
  def pubsub(*args, &block); end
  def stop_all_streams; end
  def stream_decoder(handler = nil, coder:); end
  def stream_for(model, callback = nil, coder: nil, &block); end
  def stream_from(broadcasting, callback = nil, coder: nil, &block); end
  def stream_handler(broadcasting, user_handler, coder: nil); end
  def stream_transmitter(handler = nil, broadcasting:); end
  def streams; end
  def worker_pool_stream_handler(broadcasting, user_handler, coder: nil); end
  extend ActiveSupport::Concern
end
module ActionCable::Channel::Naming
  def channel_name(*args, &block); end
  extend ActiveSupport::Concern
end
module ActionCable::Channel::Naming::ClassMethods
  def channel_name; end
end
module ActionCable::Channel::Broadcasting
  def broadcast_to(*args, &block); end
  def broadcasting_for(*args, &block); end
  extend ActiveSupport::Concern
end
module ActionCable::Channel::Broadcasting::ClassMethods
  def broadcast_to(model, message); end
  def broadcasting_for(model); end
  def serialize_broadcasting(object); end
end
class ActionCable::Channel::Base
  def __callbacks; end
  def __callbacks?; end
  def _run_subscribe_callbacks(&block); end
  def _run_unsubscribe_callbacks(&block); end
  def _subscribe_callbacks; end
  def _unsubscribe_callbacks; end
  def action_signature(action, data); end
  def connection; end
  def defer_subscription_confirmation!; end
  def defer_subscription_confirmation?; end
  def delegate_connection_identifiers; end
  def dispatch_action(action, data); end
  def ensure_confirmation_sent; end
  def extract_action(data); end
  def identifier; end
  def initialize(connection, identifier, params = nil); end
  def logger(*args, &block); end
  def params; end
  def perform_action(data); end
  def periodic_timers=(val); end
  def processable_action?(action); end
  def reject; end
  def reject_subscription; end
  def rescue_handlers; end
  def rescue_handlers=(val); end
  def rescue_handlers?; end
  def self.__callbacks; end
  def self.__callbacks=(val); end
  def self.__callbacks?; end
  def self._subscribe_callbacks; end
  def self._subscribe_callbacks=(value); end
  def self._unsubscribe_callbacks; end
  def self._unsubscribe_callbacks=(value); end
  def self.action_methods; end
  def self.clear_action_methods!; end
  def self.method_added(name); end
  def self.periodic_timers; end
  def self.periodic_timers=(val); end
  def self.periodic_timers?; end
  def self.rescue_handlers; end
  def self.rescue_handlers=(val); end
  def self.rescue_handlers?; end
  def subscribe_to_channel; end
  def subscribed; end
  def subscription_confirmation_sent?; end
  def subscription_rejected?; end
  def transmit(data, via: nil); end
  def transmit_subscription_confirmation; end
  def transmit_subscription_rejection; end
  def unsubscribe_from_channel; end
  def unsubscribed; end
  extend ActionCable::Channel::Broadcasting::ClassMethods
  extend ActionCable::Channel::Callbacks::ClassMethods
  extend ActionCable::Channel::Naming::ClassMethods
  extend ActionCable::Channel::PeriodicTimers::ClassMethods
  extend ActiveSupport::Callbacks::ClassMethods
  extend ActiveSupport::DescendantsTracker
  extend ActiveSupport::Rescuable::ClassMethods
  include ActionCable::Channel::Broadcasting
  include ActionCable::Channel::Callbacks
  include ActionCable::Channel::Naming
  include ActionCable::Channel::PeriodicTimers
  include ActionCable::Channel::Streams
  include ActiveSupport::Callbacks
  include ActiveSupport::Rescuable
end
module ActionCable::Connection
  extend ActiveSupport::Autoload
end
module ActionCable::Connection::Identification
  def connection_gid(ids); end
  def connection_identifier; end
  extend ActiveSupport::Concern
end
module ActionCable::Connection::Identification::ClassMethods
  def identified_by(*identifiers); end
end
module ActionCable::Connection::InternalChannel
  def internal_channel; end
  def process_internal_message(message); end
  def subscribe_to_internal_channel; end
  def unsubscribe_from_internal_channel; end
  extend ActiveSupport::Concern
end
module ActionCable::Connection::Authorization
  def reject_unauthorized_connection; end
end
class ActionCable::Connection::Authorization::UnauthorizedError < StandardError
end
class ActionCable::Connection::Base
  def allow_request_origin?; end
  def beat; end
  def close(reason: nil, reconnect: nil); end
  def cookies; end
  def decode(websocket_message); end
  def dispatch_websocket_message(websocket_message); end
  def encode(cable_message); end
  def env; end
  def event_loop(*args, &block); end
  def finished_request_message; end
  def handle_close; end
  def handle_open; end
  def identifiers; end
  def identifiers=(val); end
  def identifiers?; end
  def initialize(server, env, coder: nil); end
  def invalid_request_message; end
  def logger; end
  def message_buffer; end
  def new_tagged_logger; end
  def on_close(reason, code); end
  def on_error(message); end
  def on_message(message); end
  def on_open; end
  def process; end
  def protocol; end
  def pubsub(*args, &block); end
  def receive(websocket_message); end
  def request; end
  def respond_to_invalid_request; end
  def respond_to_successful_request; end
  def self.identifiers; end
  def self.identifiers=(val); end
  def self.identifiers?; end
  def send_async(method, *arguments); end
  def send_welcome_message; end
  def server; end
  def started_request_message; end
  def statistics; end
  def subscriptions; end
  def successful_request_message; end
  def transmit(cable_message); end
  def websocket; end
  def worker_pool; end
  extend ActionCable::Connection::Identification::ClassMethods
  include ActionCable::Connection::Authorization
  include ActionCable::Connection::Identification
  include ActionCable::Connection::InternalChannel
end
