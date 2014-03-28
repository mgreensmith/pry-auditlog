# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pry-auditlog/version'

Gem::Specification.new do |spec|
  spec.name          = "pry-auditlog"
  spec.version       = PryAuditlog::VERSION
  spec.authors       = ["Cozy Services Ltd.", "Matt Greensmith"]
  spec.email         = ["opensource@cozy.co"]
  spec.summary       = %q{Adds audit log capability to Pry}
  spec.description   = %q{PryAuditlog is a plugin for the Pry REPL that enables logging of any combination of Pry input and output to a configured audit log file.}
  spec.homepage      = "http://github.com/cozyco/pry-auditlog"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency 'pry', '~> 0.9'
end
