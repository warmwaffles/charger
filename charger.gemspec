# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'charger/version'

Gem::Specification.new do |gem|
  gem.name          = "charger"
  gem.version       = Charger::VERSION
  gem.authors       = ["Matthew Johnston"]
  gem.email         = ["warmwaffles@gmail.com"]
  gem.description   = %q{Utilizes Chargify's REST API}
  gem.summary       = %q{Utilizes Chargify's REST API}
  gem.homepage      = "https://github.com/warmwaffles/charger"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('virtus')
  gem.add_runtime_dependency('active_support')
  gem.add_runtime_dependency('multi_json')
  gem.add_runtime_dependency('rest-client')

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('rspec-core')
  gem.add_development_dependency('rspec-mocks')
  gem.add_development_dependency('rspec-expectations')
  gem.add_development_dependency('shoulda-matchers')
end
