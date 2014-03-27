require 'pry'
require 'pry-auditlog/version'
require 'pry-auditlog/logger'
require 'pry-auditlog/output'

Pry.config.auditlog_enabled ||= false
Pry.config.auditlog_file ||= nil

require 'ext/pry/history'

Pry.history.load_auditor
original_output = Pry.config.output
Pry.config.output = PryAuditlog::Output.new
#Pry.config.output.set_original_output(original_output)

Pry.config.print = proc do |output, value, _pry_|
  PryAuditlog::Logger.log_output(Pry.output_with_default_format(output, value, :hashrocket => true))
  _pry_.output_with_default_format(original_output, value, :hashrocket => true)
end