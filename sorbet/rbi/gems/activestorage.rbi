# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strong
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/activestorage/all/activestorage.rbi
#
# activestorage-6.0.3.1

module ActiveStorage
  def analyzers; end
  def analyzers=(obj); end
  def binary_content_type; end
  def binary_content_type=(obj); end
  def content_types_allowed_inline; end
  def content_types_allowed_inline=(obj); end
  def content_types_to_serve_as_binary; end
  def content_types_to_serve_as_binary=(obj); end
  def logger; end
  def logger=(obj); end
  def paths; end
  def paths=(obj); end
  def previewers; end
  def previewers=(obj); end
  def queues; end
  def queues=(obj); end
  def replace_on_assign_to_many; end
  def replace_on_assign_to_many=(obj); end
  def routes_prefix; end
  def routes_prefix=(obj); end
  def self.analyzers; end
  def self.analyzers=(obj); end
  def self.binary_content_type; end
  def self.binary_content_type=(obj); end
  def self.content_types_allowed_inline; end
  def self.content_types_allowed_inline=(obj); end
  def self.content_types_to_serve_as_binary; end
  def self.content_types_to_serve_as_binary=(obj); end
  def self.gem_version; end
  def self.logger; end
  def self.logger=(obj); end
  def self.paths; end
  def self.paths=(obj); end
  def self.previewers; end
  def self.previewers=(obj); end
  def self.queues; end
  def self.queues=(obj); end
  def self.railtie_helpers_paths; end
  def self.railtie_namespace; end
  def self.railtie_routes_url_helpers(include_path_helpers = nil); end
  def self.replace_on_assign_to_many; end
  def self.replace_on_assign_to_many=(obj); end
  def self.routes_prefix; end
  def self.routes_prefix=(obj); end
  def self.service_urls_expire_in; end
  def self.service_urls_expire_in=(obj); end
  def self.table_name_prefix; end
  def self.use_relative_model_naming?; end
  def self.variable_content_types; end
  def self.variable_content_types=(obj); end
  def self.variant_processor; end
  def self.variant_processor=(obj); end
  def self.verifier; end
  def self.verifier=(obj); end
  def self.version; end
  def service_urls_expire_in; end
  def service_urls_expire_in=(obj); end
  def variable_content_types; end
  def variable_content_types=(obj); end
  def variant_processor; end
  def variant_processor=(obj); end
  def verifier; end
  def verifier=(obj); end
  extend ActiveSupport::Autoload
end
module ActiveStorage::VERSION
end
class ActiveStorage::Error < StandardError
end
class ActiveStorage::InvariableError < ActiveStorage::Error
end
class ActiveStorage::UnpreviewableError < ActiveStorage::Error
end
class ActiveStorage::UnrepresentableError < ActiveStorage::Error
end
class ActiveStorage::IntegrityError < ActiveStorage::Error
end
class ActiveStorage::FileNotFoundError < ActiveStorage::Error
end
module ActiveStorage::Transformers
  extend ActiveSupport::Autoload
end
class ActiveStorage::Previewer
  def blob; end
  def capture(*argv, to:); end
  def download_blob_to_tempfile(&block); end
  def draw(*argv); end
  def initialize(blob); end
  def instrument(operation, payload = nil, &block); end
  def logger; end
  def open_tempfile; end
  def preview; end
  def self.accept?(blob); end
  def tmpdir; end
end
class ActiveStorage::Previewer::PopplerPDFPreviewer < ActiveStorage::Previewer
  def draw_first_page_from(file, &block); end
  def preview; end
  def self.accept?(blob); end
  def self.pdftoppm_exists?; end
  def self.pdftoppm_path; end
end
class ActiveStorage::Previewer::MuPDFPreviewer < ActiveStorage::Previewer
  def draw_first_page_from(file, &block); end
  def preview; end
  def self.accept?(blob); end
  def self.mutool_exists?; end
  def self.mutool_path; end
end
class ActiveStorage::Previewer::VideoPreviewer < ActiveStorage::Previewer
  def draw_relevant_frame_from(file, &block); end
  def preview; end
  def self.accept?(blob); end
  def self.ffmpeg_exists?; end
  def self.ffmpeg_path; end
end
class ActiveStorage::Analyzer
  def blob; end
  def download_blob_to_tempfile(&block); end
  def initialize(blob); end
  def logger; end
  def metadata; end
  def self.accept?(blob); end
  def tmpdir; end
end
class ActiveStorage::Analyzer::ImageAnalyzer < ActiveStorage::Analyzer
  def metadata; end
  def read_image; end
  def rotated_image?(image); end
  def self.accept?(blob); end
end
class ActiveStorage::Analyzer::VideoAnalyzer < ActiveStorage::Analyzer
  def angle; end
  def computed_height; end
  def display_aspect_ratio; end
  def display_height_scale; end
  def duration; end
  def encoded_height; end
  def encoded_width; end
  def ffprobe_path; end
  def height; end
  def metadata; end
  def probe; end
  def probe_from(file); end
  def rotated?; end
  def self.accept?(blob); end
  def streams; end
  def tags; end
  def video_stream; end
  def width; end
end
module ActiveStorage::Reflection
end
class ActiveStorage::Reflection::HasOneAttachedReflection < ActiveRecord::Reflection::MacroReflection
  def macro; end
end
class ActiveStorage::Reflection::HasManyAttachedReflection < ActiveRecord::Reflection::MacroReflection
  def macro; end
end
module ActiveStorage::Reflection::ReflectionExtension
  def add_attachment_reflection(model, name, reflection); end
  def reflection_class_for(macro); end
end
module ActiveStorage::Reflection::ActiveRecordExtensions
  extend ActiveSupport::Concern
end
module ActiveStorage::Reflection::ActiveRecordExtensions::ClassMethods
  def reflect_on_all_attachments; end
  def reflect_on_attachment(attachment); end
end
class ActiveStorage::Engine < Rails::Engine
end
