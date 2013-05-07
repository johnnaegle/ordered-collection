$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ordered-collection/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ordered-collection"
  s.version     = OrderedCollection::VERSION
  s.authors     = ["John Naegle"]
  s.email       = ["john.naegle@gmail.com"]
  s.homepage    = "https://github.com/johnnaegle/ordered-collection"
  s.summary     = "allows ActiveRecord models to persist a has_many association with an order column that is maintained starting at zero and without gaps"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"


#  s.add_development_dependency "debugger"
  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
end
