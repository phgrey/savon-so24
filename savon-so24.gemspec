$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "savon/so24/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "savon-so24"
  s.version     = Savon::So24::VERSION
  s.authors     = ["Sergey Semenov"]
  s.email       = ["phgrey@gmail.com"]
  s.homepage    = "https://github.com/phgrey/savon-so24"
  s.summary     = "Client for 24sevenoffice service based on Savon"
  s.description = "ActiveRecord extension used for connecting application models with 24so classes"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "savon", "~> 2.2.0"
  #s.add_dependency "wasabi"


  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'factory_girl'

  s.add_development_dependency "sqlite3"
end
