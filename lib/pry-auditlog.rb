require 'pry'
require 'pry-auditlog/version'
require 'pry-auditlog/logger'
require 'pry-auditlog/output'

Pry.config.auditlog_enabled ||= false
Pry.config.auditlog_file ||= nil
Pry.config.orig_stdout = $stdout
Pry.config.orig_stderr = $stderr

require 'ext/pry/history'

Pry.history.load_auditor
original_output = Pry.config.output
Pry.config.output = PryAuditlog::Output.new
Pry.config.output.set_original_output(original_output)

Pry.config.hooks.add_hook(:before_session, :hijack_stdout) do
  old_stdout, old_stderr = $stdout, $old_stderr
  $stdout = $stderr = Pry.config.output
end

Pry.config.hooks.add_hook(:after_session, :unhijack_stdout) do
  $stdout = Pry.config.orig_stdout
  $stderr = Pry.config.orig_stderr
end


