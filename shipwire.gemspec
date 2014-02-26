$:.push File.expand_path("../lib", __FILE__)

require "shipwire/version"

Gem::Specification.new do |s|
  s.name        = "shipwire"
  s.version     = Shipwire::VERSION
  s.authors     = ["Marc Roberts"]
  s.email       = ["marc@neutroncreations.com"]
  s.homepage    = "https://github.com/marcroberts/shipwire"
  s.summary     = "Ruby bindings for the Shipwire API."
  s.description = "Enterprise logistics for everyone."

  s.files = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency "httparty", "~> 0.13.0"
  s.add_dependency "builder"

end
