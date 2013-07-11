# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'durable_decorator_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "durable_decorator_rails"
  spec.version       = DurableDecoratorRails::VERSION
  spec.authors       = ["Denis Ivanov"]
  spec.email         = ["visible.h4x@gmail.com"]
  spec.description   = 'Ties durable_decorator to rails and provides a few helpful utility rake tasks that rely on the Rails ENV being loaded into memory'
  spec.summary       = 'Rails integration for durable_decorator'
  spec.homepage      = "https://github.com/jumph4x/durable_decorator_rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "durable_decorator", "~> 0.0.8"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
