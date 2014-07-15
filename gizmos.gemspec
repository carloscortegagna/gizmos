$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gizmos/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gizmos"
  s.version     = Gizmos::VERSION
  s.authors     = ["Carlo Scortegagna"]
  s.email       = ["carloscortegagna@gmail.com"]
  s.homepage    = "http://github.com/carloscortegagna/gizmos"
  s.summary     = "Rails Engine for inline editing with RailsAdmin"
  s.description = "Rails Engine for inline editing with RailsAdmin"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.4"
  s.add_dependency "rails_admin", "~> 0.6.2"

  s.add_development_dependency "sqlite3"
end
