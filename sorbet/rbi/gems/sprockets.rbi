# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/sprockets/all/sprockets.rbi
#
# sprockets-4.0.2

module Sprockets
  extend Sprockets::Configuration
  extend Sprockets::ProcessorUtils
end
module Sprockets::DigestUtils
  def build_digest(obj); end
  def detect_digest_class(bytes); end
  def digest(obj); end
  def digest_class; end
  def hexdigest(obj); end
  def hexdigest_integrity_uri(hexdigest); end
  def integrity_uri(digest); end
  def pack_base64digest(bin); end
  def pack_hexdigest(bin); end
  def pack_urlsafe_base64digest(bin); end
  def unpack_hexdigest(hex); end
  extend Sprockets::DigestUtils
end
class Sprockets::Cache
  def clear(options = nil); end
  def expand_key(key); end
  def fetch(key); end
  def get(key, local = nil); end
  def get_cache_wrapper(cache); end
  def initialize(cache = nil, logger = nil); end
  def inspect; end
  def peek_key(key); end
  def self.default_logger; end
  def set(key, value, local = nil); end
end
class Anonymous_Struct_461 < Struct
  def cache; end
  def cache=(_); end
  def self.[](*arg0); end
  def self.inspect; end
  def self.members; end
  def self.new(*arg0); end
end
class Sprockets::Cache::Wrapper < Anonymous_Struct_461
end
class Sprockets::Cache::GetWrapper < Sprockets::Cache::Wrapper
  def clear(options = nil); end
  def get(key); end
  def set(key, value); end
end
class Sprockets::Cache::HashWrapper < Sprockets::Cache::Wrapper
  def clear(options = nil); end
  def get(key); end
  def set(key, value); end
end
class Sprockets::Cache::ReadWriteWrapper < Sprockets::Cache::Wrapper
  def clear(options = nil); end
  def get(key); end
  def set(key, value); end
end
class Sprockets::Asset
  def ==(other); end
  def base64digest; end
  def bytesize; end
  def charset; end
  def content_type; end
  def digest; end
  def digest_path; end
  def each; end
  def environment_version; end
  def eql?(other); end
  def etag; end
  def filename; end
  def full_digest_path; end
  def hash; end
  def hexdigest; end
  def id; end
  def initialize(attributes = nil); end
  def inspect; end
  def integrity; end
  def length; end
  def links; end
  def logical_path; end
  def metadata; end
  def source; end
  def to_hash; end
  def to_s; end
  def uri; end
  def write_to(filename); end
end
module Sprockets::Bower
  def read_bower_main(dirname, filename); end
  def resolve_alternates(load_path, logical_path); end
end
module Sprockets::Utils
  def concat_javascript_sources(buf, source); end
  def dfs(initial); end
  def dfs_paths(path); end
  def duplicable?(obj); end
  def hash_reassoc(hash, key_a, key_b = nil, &block); end
  def hash_reassoc1(hash, key); end
  def module_include(base, mod); end
  def string_end_with_semicolon?(str); end
  extend Sprockets::Utils
end
module Sprockets::Compressing
  def compressors; end
  def css_compressor; end
  def css_compressor=(compressor); end
  def gzip=(gzip); end
  def gzip?; end
  def js_compressor; end
  def js_compressor=(compressor); end
  def register_compressor(mime_type, sym, klass); end
  def skip_gzip?; end
  include Sprockets::Utils
end
module Sprockets::PathUtils
  def absolute_path?(path); end
  def atomic_write(filename); end
  def directory?(path); end
  def entries(path); end
  def file?(path); end
  def find_matching_path_for_extensions(path, basename, extensions); end
  def find_upwards(basename, path, root = nil); end
  def join(base, path); end
  def match_path_extname(path, extensions); end
  def path_extnames(path); end
  def path_parents(path, root = nil); end
  def paths_split(paths, filename); end
  def relative_path?(path); end
  def relative_path_from(start, dest); end
  def set_pipeline(path, mime_exts, pipeline_exts, pipeline); end
  def split_subpath(path, subpath); end
  def stat(path); end
  def stat_directory(dir); end
  def stat_sorted_tree(dir, &block); end
  def stat_tree(dir, &block); end
  extend Sprockets::PathUtils
end
module Sprockets::PathDigestUtils
  def file_digest(path); end
  def files_digest(paths); end
  def stat_digest(path, stat); end
  include Sprockets::DigestUtils
end
module Sprockets::URIUtils
  def build_asset_uri(path, params = nil); end
  def build_file_digest_uri(path); end
  def encode_uri_query_params(params); end
  def join_file_uri(scheme, host, path, query); end
  def join_uri(scheme, userinfo, host, port, registry, path, opaque, query, fragment); end
  def parse_asset_uri(uri); end
  def parse_file_digest_uri(uri); end
  def parse_uri_query_params(query); end
  def split_file_uri(uri); end
  def split_uri(uri); end
  def valid_asset_uri?(str); end
  extend Sprockets::URIUtils
end
module Sprockets::Dependencies
  def add_dependency(uri); end
  def depend_on(uri); end
  def dependencies; end
  def dependency_resolvers; end
  def register_dependency_resolver(scheme, &block); end
  def resolve_dependency(str); end
  include Sprockets::DigestUtils
end
module Sprockets::EncodingUtils
  def base64(str); end
  def charlock_detect(str); end
  def deflate(str); end
  def detect(str); end
  def detect_css(str); end
  def detect_html(str); end
  def detect_unicode(str); end
  def detect_unicode_bom(str); end
  def gzip(str); end
  def scan_css_charset(str); end
  def unmarshaled_deflated(str, window_bits = nil); end
  extend Sprockets::EncodingUtils
end
module Sprockets::HTTPUtils
  def find_best_mime_type_match(q_value_header, available); end
  def find_best_q_match(q_values, available, &matcher); end
  def find_mime_type_matches(q_value_header, available); end
  def find_q_matches(q_values, available, &matcher); end
  def match_mime_type?(value, matcher); end
  def match_mime_type_keys(hash, mime_type); end
  def parse_q_values(values); end
  extend Sprockets::HTTPUtils
end
module Sprockets::Mime
  def mime_exts; end
  def mime_type_charset_detecter(mime_type); end
  def mime_types; end
  def read_file(filename, content_type = nil); end
  def register_mime_type(mime_type, extensions: nil, charset: nil); end
  include Sprockets::HTTPUtils
end
module Sprockets::Paths
  def append_path(path); end
  def clear_paths; end
  def each_file; end
  def paths; end
  def prepend_path(path); end
  def root; end
  def root=(path); end
  include Sprockets::PathUtils
end
class Sprockets::FileReader
  def self.call(input); end
end
module Sprockets::ProcessorUtils
  def call_processor(processor, input); end
  def call_processors(processors, input); end
  def compose_processors(*processors); end
  def processor_cache_key(processor); end
  def processors_cache_keys(processors); end
  def validate_processor_result!(result); end
  extend Sprockets::ProcessorUtils
end
class Anonymous_Struct_462 < Struct
  def param; end
  def param=(_); end
  def processor_strategy; end
  def processor_strategy=(_); end
  def processors; end
  def processors=(_); end
  def self.[](*arg0); end
  def self.inspect; end
  def self.members; end
  def self.new(*arg0); end
end
class Sprockets::ProcessorUtils::CompositeProcessor < Anonymous_Struct_462
  def cache_key; end
  def call(input); end
  def self.create(processors); end
end
module Sprockets::Processing
  def build_processors_uri(type, file_type, pipeline); end
  def bundle_processors; end
  def default_processors_for(type, file_type); end
  def pipelines; end
  def postprocessors; end
  def preprocessors; end
  def processors; end
  def processors_for(type, file_type, pipeline); end
  def register_bundle_metadata_reducer(mime_type, key, *args, &block); end
  def register_bundle_processor(*args, &block); end
  def register_config_processor(type, mime_type, processor = nil, &block); end
  def register_pipeline(name, proc = nil, &block); end
  def register_postprocessor(*args, &block); end
  def register_preprocessor(*args, &block); end
  def register_processor(*args, &block); end
  def resolve_processors_cache_key_uri(uri); end
  def self_processors_for(type, file_type); end
  def unregister_bundle_processor(*args); end
  def unregister_config_processor(type, mime_type, processor); end
  def unregister_postprocessor(*args); end
  def unregister_preprocessor(*args); end
  def unregister_processor(*args); end
  include Sprockets::ProcessorUtils
end
module Sprockets::Exporting
  def export_concurrent; end
  def export_concurrent=(export_concurrent); end
  def exporters; end
  def register_exporter(mime_types, klass = nil); end
  def unregister_exporter(mime_types, exporter = nil); end
end
module Sprockets::Transformers
  def compose_transformer_list(transformers, preprocessors, postprocessors); end
  def compose_transformers(transformers, types, preprocessors, postprocessors); end
  def compute_transformers!(registered_transformers); end
  def expand_transform_accepts(parsed_accepts); end
  def register_transformer(from, to, proc); end
  def register_transformer_suffix(types, type_format, extname, processor); end
  def resolve_transform_type(type, accept); end
  def transformers; end
  include Sprockets::HTTPUtils
end
class Sprockets::Transformers::Transformer < Struct
  def from; end
  def from=(_); end
  def proc; end
  def proc=(_); end
  def self.[](*arg0); end
  def self.inspect; end
  def self.members; end
  def self.new(*arg0); end
  def to; end
  def to=(_); end
end
module Sprockets::Configuration
  def config; end
  def config=(config); end
  def context_class; end
  def digest_class; end
  def digest_class=(klass); end
  def initialize_configuration(parent); end
  def logger; end
  def logger=(arg0); end
  def version; end
  def version=(version); end
  include Sprockets::Paths
end
class Sprockets::Error < StandardError
end
class Sprockets::ArgumentError < Sprockets::Error
end
class Sprockets::ContentTypeMismatch < Sprockets::Error
end
class Sprockets::NotImplementedError < Sprockets::Error
end
class Sprockets::NotFound < Sprockets::Error
end
class Sprockets::ConversionError < Sprockets::NotFound
end
class Sprockets::FileNotFound < Sprockets::NotFound
end
class Sprockets::FileOutsidePaths < Sprockets::NotFound
end
module Sprockets::PathDependencyUtils
  def entries_with_dependencies(path); end
  def stat_directory_with_dependencies(dir); end
  def stat_sorted_tree_with_dependencies(dir); end
  include Sprockets::PathUtils
  include Sprockets::URIUtils
end
module Sprockets::Resolve
  def parse_accept_options(mime_type, explicit_type); end
  def resolve!(path, **kargs); end
  def resolve(path, load_paths: nil, accept: nil, pipeline: nil, base_path: nil); end
  def resolve_absolute_path(paths, filename, accept); end
  def resolve_alternates(load_path, logical_name); end
  def resolve_alts_under_path(load_path, logical_name, mime_exts); end
  def resolve_asset_uri(uri); end
  def resolve_index_under_path(load_path, logical_name, mime_exts); end
  def resolve_logical_path(paths, logical_path, accept); end
  def resolve_main_under_path(load_path, logical_name, mime_exts); end
  def resolve_relative_path(paths, path, dirname, accept); end
  def resolve_under_paths(paths, logical_name, accepts); end
  include Sprockets::HTTPUtils
end
class Sprockets::URITar
  def absolute_path?; end
  def compress; end
  def compressed_path; end
  def expand; end
  def initialize(uri, env); end
  def path; end
  def root; end
  def scheme; end
end
class Sprockets::UnloadedAsset
  def asset_key; end
  def compressed_path; end
  def dependency_history_key; end
  def digest_key(digest); end
  def file_digest_key(stat); end
  def filename; end
  def initialize(uri, env); end
  def load_file_params; end
  def params; end
  def uri; end
end
module Sprockets::Loader
  def asset_from_cache(key); end
  def compress_key_from_hash(hash, key); end
  def expand_key_from_hash(hash, key); end
  def fetch_asset_from_dependency_cache(unloaded, limit = nil); end
  def load(uri); end
  def load_from_unloaded(unloaded); end
  def resolve_dependencies(uris); end
  def store_asset(asset, unloaded); end
  include Sprockets::DigestUtils
  include Sprockets::Mime
end
module Sprockets::Npm
  def read_package_directives(dirname, filename); end
  def resolve_alternates(load_path, logical_path); end
end
module Sprockets::Server
  def bad_request_response(env); end
  def cache_headers(env, etag); end
  def call(env); end
  def css_exception_response(exception); end
  def escape_css_content(content); end
  def forbidden_request?(path); end
  def forbidden_response(env); end
  def head_request?(env); end
  def headers(env, asset, length); end
  def javascript_exception_response(exception); end
  def method_not_allowed_response; end
  def not_found_response(env); end
  def not_modified_response(env, etag); end
  def ok_response(asset, env); end
  def path_fingerprint(path); end
  def precondition_failed_response(env); end
end
module Sprockets::SourceMapUtils
  def bsearch_mappings(mappings, offset, from = nil, to = nil); end
  def combine_source_maps(first, second); end
  def compare_source_offsets(a, b); end
  def concat_source_maps(a, b); end
  def decode_source_map(map); end
  def decode_vlq_mappings(str, sources: nil, names: nil); end
  def encode_source_map(map); end
  def encode_vlq_mappings(mappings, sources: nil, names: nil); end
  def format_source_map(map, input); end
  def make_index_map(map); end
  def vlq_decode(str); end
  def vlq_decode_mappings(str); end
  def vlq_encode(ary); end
  def vlq_encode_mappings(ary); end
  extend Sprockets::SourceMapUtils
end
class Sprockets::DoubleLinkError < Sprockets::Error
  def initialize(parent_filename:, logical_path:, last_filename:, filename:); end
end
class Sprockets::Base
  def [](*args, **options); end
  def cache; end
  def cache=(cache); end
  def cached; end
  def compress_from_root(uri); end
  def expand_from_root(uri); end
  def file_digest(path); end
  def find_all_linked_assets(*args); end
  def find_asset!(*args); end
  def find_asset(*args, **options); end
  def index; end
  def inspect; end
  include Sprockets::Bower
  include Sprockets::Configuration
  include Sprockets::Npm
  include Sprockets::PathUtils
  include Sprockets::Resolve
  include Sprockets::Server
end
class Sprockets::Cache::MemoryStore
  def clear(options = nil); end
  def get(key); end
  def initialize(max_size = nil); end
  def inspect; end
  def set(key, value); end
end
class Sprockets::CachedEnvironment < Sprockets::Base
  def cached; end
  def config=(config); end
  def entries(path); end
  def index; end
  def initialize(environment); end
  def load(uri); end
  def processor_cache_key(str); end
  def resolve_dependency(str); end
  def stat(path); end
end
class Sprockets::Environment < Sprockets::Base
  def cached; end
  def find_all_linked_assets(*args, &block); end
  def find_asset!(*args); end
  def find_asset(*args, **options); end
  def index; end
  def initialize(root = nil); end
  def load(*args); end
end
module Sprockets::ManifestUtils
  def find_directory_manifest(dirname, logger = nil); end
  def generate_manifest_path; end
  extend Sprockets::ManifestUtils
end
class Sprockets::Manifest
  def assets; end
  def clean(count = nil, age = nil); end
  def clobber; end
  def compile(*args); end
  def dir; end
  def directory; end
  def environment; end
  def executor; end
  def exporters_for_asset(asset); end
  def filename; end
  def files; end
  def find(*args); end
  def find_sources(*args); end
  def initialize(*args); end
  def json_decode(obj); end
  def json_encode(obj); end
  def logger; end
  def path; end
  def remove(filename); end
  def save; end
  include Sprockets::ManifestUtils
end
class Sprockets::Context
  def asset_data_uri(path); end
  def asset_path(path, options = nil); end
  def audio_path(path); end
  def base64_asset_data_uri(asset); end
  def content_type; end
  def depend_on(path); end
  def depend_on_asset(path); end
  def depend_on_env(key); end
  def env_proxy; end
  def environment; end
  def filename; end
  def font_path(path); end
  def image_path(path); end
  def initialize(input); end
  def javascript_path(path); end
  def link_asset(path); end
  def load(uri); end
  def load_path; end
  def logical_path; end
  def metadata; end
  def optimize_quoted_uri_escapes!(escaped); end
  def optimize_svg_for_uri_escaping!(svg); end
  def require_asset(path); end
  def resolve(path, **kargs); end
  def root_path; end
  def stub_asset(path); end
  def stylesheet_path(path); end
  def svg_asset_data_uri(asset); end
  def video_path(path); end
end
class Sprockets::Context::ENVProxy < SimpleDelegator
  def [](key); end
  def fetch(key, *arg1); end
  def initialize(context); end
end
class Sprockets::SourceMapProcessor
  def self.call(input); end
  def self.original_content_type(source_map_content_type, error_when_not_found: nil); end
end
class Sprockets::AddSourceMapCommentToAssetProcessor
  def self.call(input); end
end
class Sprockets::DirectiveProcessor
  def _call(input); end
  def call(input); end
  def compile_header_pattern(comments); end
  def expand_accept_shorthand(accept); end
  def expand_relative_dirname(directive, path); end
  def extract_directives(header); end
  def initialize(comments: nil); end
  def link_paths(paths, deps, accept); end
  def process_depend_on_asset_directive(path); end
  def process_depend_on_directive(path); end
  def process_directives(directives); end
  def process_link_directive(path); end
  def process_link_directory_directive(path = nil, accept = nil); end
  def process_link_tree_directive(path = nil, accept = nil); end
  def process_require_directive(path); end
  def process_require_directory_directive(path = nil); end
  def process_require_self_directive; end
  def process_require_tree_directive(path = nil); end
  def process_source(source); end
  def process_stub_directive(path); end
  def require_paths(paths, deps); end
  def resolve(path, **kargs); end
  def resolve_paths(paths, deps, **kargs); end
  def self.call(input); end
  def self.instance; end
  def to_load(uri); end
end
class Sprockets::Bundle
  def self.call(input); end
  def self.dedup(required); end
  def self.process_bundle_reducers(input, assets, reducers); end
end
module Sprockets::Autoload
end
class Sprockets::ClosureCompressor
  def cache_key; end
  def call(input); end
  def initialize(options = nil); end
  def self.cache_key; end
  def self.call(input); end
  def self.instance; end
end
class Sprockets::SassCompressor
  def cache_key; end
  def call(input); end
  def initialize(options = nil); end
  def self.cache_key; end
  def self.call(input); end
  def self.instance; end
end
class Sprockets::SasscCompressor
  def call(input); end
  def initialize(options = nil); end
  def self.call(input); end
  def self.instance; end
end
class Sprockets::JSMincCompressor
  def cache_key; end
  def call(input); end
  def initialize(options = nil); end
  def self.cache_key; end
  def self.call(input); end
  def self.instance; end
end
class Sprockets::UglifierCompressor
  def cache_key; end
  def call(input); end
  def initialize(options = nil); end
  def self.cache_key; end
  def self.call(input); end
  def self.instance; end
end
class Sprockets::YUICompressor
  def cache_key; end
  def call(input); end
  def initialize(options = nil); end
  def self.cache_key; end
  def self.call(input); end
  def self.instance; end
end
class Sprockets::BabelProcessor
  def cache_key; end
  def call(input); end
  def initialize(options = nil); end
  def self.cache_key; end
  def self.call(input); end
  def self.instance; end
end
module Sprockets::CoffeeScriptProcessor
  def self.cache_key; end
  def self.call(input); end
end
module Sprockets::EcoProcessor
  def self.cache_key; end
  def self.call(input); end
end
module Sprockets::EjsProcessor
  def self.cache_key; end
  def self.call(input); end
end
class Sprockets::JstProcessor
  def call(input); end
  def initialize(namespace: nil); end
  def self.call(input); end
  def self.default_namespace; end
  def self.instance; end
end
class Sprockets::SasscProcessor
  def cache_key; end
  def call(input); end
  def engine_options(input, context); end
  def initialize(options = nil, &block); end
  def merge_options(options); end
  def self.cache_key; end
  def self.call(input); end
  def self.instance; end
  def self.syntax; end
end
module Sprockets::SasscProcessor::Functions
  def asset_data_url(path); end
  def asset_path(path, options = nil); end
  def asset_url(path, options = nil); end
  def audio_path(path); end
  def audio_url(path); end
  def font_path(path); end
  def font_url(path); end
  def image_path(path); end
  def image_url(path); end
  def javascript_path(path); end
  def javascript_url(path); end
  def sprockets_context; end
  def sprockets_dependencies; end
  def sprockets_environment; end
  def stylesheet_path(path); end
  def stylesheet_url(path); end
  def video_path(path); end
  def video_url(path); end
end
class Sprockets::ScsscProcessor < Sprockets::SasscProcessor
  def self.syntax; end
end
class Sprockets::ERBProcessor
  def call(input); end
  def initialize(&block); end
  def self.call(input); end
  def self.instance; end
end
module Sprockets::Exporters
end
class Sprockets::Exporters::Base
  def asset; end
  def call; end
  def directory; end
  def environment; end
  def initialize(asset: nil, environment: nil, directory: nil); end
  def setup; end
  def skip?(logger); end
  def target; end
  def write(filename = nil); end
end
class Sprockets::Exporters::FileExporter < Sprockets::Exporters::Base
  def call; end
  def skip?(logger); end
end
class Sprockets::Utils::Gzip
  def archiver; end
  def can_compress?; end
  def cannot_compress?; end
  def charset; end
  def compress(file, target); end
  def content_type; end
  def initialize(asset, archiver: nil); end
  def source; end
end
module Sprockets::Utils::Gzip::ZlibArchiver
  def self.call(file, source, mtime); end
end
module Sprockets::Utils::Gzip::ZopfliArchiver
  def self.call(file, source, mtime); end
end
class Sprockets::Exporters::ZlibExporter < Sprockets::Exporters::Base
  def call; end
  def setup; end
  def skip?(logger); end
end
class Sprockets::Exporters::ZopfliExporter < Sprockets::Exporters::ZlibExporter
  def setup; end
end
module Sprockets::Preprocessors
end
class Sprockets::Preprocessors::DefaultSourceMap
  def call(input); end
  def default_mappings(lines); end
end
