# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pry-auditlog/version'

Gem::Specification.new do |spec|
  spec.name          = "pry-auditlog"
  spec.version       = PryAuditlog::VERSION
  spec.authors       = ["Matt Greensmith"]
  spec.email         = ["matt.greensmith@gmail.com"]
  spec.summary       = %q{Adds audit log capability to pry}
  spec.description   = %q{Copies all input and ouput to a specified audit log file}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
