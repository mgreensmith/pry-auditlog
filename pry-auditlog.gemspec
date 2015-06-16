# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pry-auditlog/version'

Gem::Specification.new do |spec|
  spec.name          = 'pry-auditlog'
  spec.version       = PryAuditlog::VERSION
  spec.authors       = ['Matt Greensmith', 'Cozy Services Ltd.']
  spec.email         = ['matt@mattgreensmith.net', 'opensource@cozy.co']
  spec.summary       = %q{Adds audit log capability to Pry}
  spec.description   = %q{PryAuditlog is a plugin for the Pry REPL that enables logging of any combination of Pry input and output to a configured audit log file.}
  spec.homepage      = 'http://github.com/cozyco/pry-auditlog'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_dependency 'pry', '~> 0.10'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
