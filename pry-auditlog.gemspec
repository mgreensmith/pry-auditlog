# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pry-auditlog/version'

Gem::Specification.new do |spec|
  spec.name          = "pry-auditlog"
  spec.version       = PryAuditlog::VERSION
  spec.authors       = ["Matt Greensmith"]
  spec.email         = ["mgreensmith@cozy.co"]
  spec.summary       = %q{Adds audit log capability to Pry}
  spec.description   = %q{Logs configured combinations of Pry input and ouput to a specified audit log file.}
  spec.homepage      = "http://github.com/cozyco/pry-auditlog"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency 'pry', '~> 0.9'
end
