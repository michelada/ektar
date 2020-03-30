# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: true
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/bundler-audit/all/bundler-audit.rbi
#
# bundler-audit-0.6.1

module Bundler
end
module Bundler::Audit
end
class Anonymous_Struct_419 < Struct
  def cve; end
  def cve=(_); end
  def cvss_v2; end
  def cvss_v2=(_); end
  def date; end
  def date=(_); end
  def description; end
  def description=(_); end
  def id; end
  def id=(_); end
  def osvdb; end
  def osvdb=(_); end
  def patched_versions; end
  def patched_versions=(_); end
  def path; end
  def path=(_); end
  def self.[](*arg0); end
  def self.inspect; end
  def self.members; end
  def self.new(*arg0); end
  def title; end
  def title=(_); end
  def unaffected_versions; end
  def unaffected_versions=(_); end
  def url; end
  def url=(_); end
end
class Bundler::Audit::Advisory < Anonymous_Struct_419
  def criticality; end
  def cve_id; end
  def osvdb_id; end
  def patched?(version); end
  def self.load(path); end
  def to_s; end
  def unaffected?(version); end
  def vulnerable?(version); end
end
class Bundler::Audit::Database
  def advisories(&block); end
  def advisories_for(name); end
  def check_gem(gem); end
  def each_advisory_path(&block); end
  def each_advisory_path_for(name, &block); end
  def initialize(path = nil); end
  def inspect; end
  def path; end
  def self.path; end
  def self.update!(options = nil); end
  def size; end
  def to_s; end
end
