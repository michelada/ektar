$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "ektar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name = "ektar"
  spec.version = Ektar::VERSION
  spec.authors = ["Mario Alberto Chávez", "Galilea Lopez", "Nataly Silva"]
  spec.email = ["mario@michelada.io", "galilea.lopez@michelada.io", "nataly.silva@michelada.io"]
  spec.homepage = "https://michelada.io"
  spec.summary = "Summary of Ektar."
  spec.description = "Description of Ektar."
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib,public}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2"
  spec.add_dependency "pagy", "~> 3.7.0"
  spec.add_dependency "sorbet-runtime", "~> 0.5.0"
  spec.add_dependency "sorbet-rails", "~> 0.5.0"
  spec.add_dependency "pg_search", "~> 2.3.0"
  spec.add_development_dependency "lefthook"
  spec.add_development_dependency "pg"
  spec.add_development_dependency "sorbet"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "brakeman"
  spec.add_development_dependency "bundle-audit"
end
