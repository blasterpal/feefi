# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feefi/version'

Gem::Specification.new do |spec|
  spec.name          = "feefi"
  spec.version       = Feefi::VERSION
  spec.authors       = ["Hank Beaver"]
  spec.email         = ["hbeaver@gmail.com"]
  spec.description   = %q{ Feefi, a not-so-giant sized CLI for AWS Elastic Beanstalk}
  spec.summary       = %q{}
  spec.homepage      = "http://www.github.com/blasterpal/feefi"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_dependency "thor"
  spec.add_dependency "fog"
  spec.add_dependency 'hashie'


end
