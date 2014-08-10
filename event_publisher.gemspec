$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "event_publisher/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "event_publisher"
  s.version     = EventPublisher::VERSION
  s.authors     = ["Mohamed Magdy"]
  s.email       = ["mohamed.magdy.aly@gmail.com"]
  s.summary     = "Track and publish user events"
  s.description = "Track and publish user events"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.19"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
end
