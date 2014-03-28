require 'pry'
require 'pry-auditlog/version'
require 'pry-auditlog/logger'
require 'pry-auditlog/output'


Pry.config.auditlog_enabled ||= false
Pry.config.auditlog_file ||= "~/.pry_auditlog"
Pry.config.auditlog_log_input ||= true
Pry.config.auditlog_log_output ||= true

if Pry.config.auditlog_enabled
  if Pry.config.auditlog_log_input
    require 'ext/pry/history'
    require 'ext/pry/pry_instance'
  end

  if Pry.config.auditlog_log_output
    Pry.config._orig_stdout = $stdout
    Pry.config._orig_stderr = $stderr

    original_output = Pry.config.output
    Pry.config.output = PryAuditlog::Output.new
    Pry.config.output._set_original_output(original_output)
  end

  Pry.config.hooks.add_hook(:before_session, :prepare_auditlog) do
    $stdout = $stderr = Pry.config.output if Pry.config.auditlog_log_output
    PryAuditlog::Logger.set_session_token(Time.now.to_i)
    PryAuditlog::Logger.log("AUDIT LOG", "Pry session started")
  end

  Pry.config.hooks.add_hook(:after_session, :unhijack_stdout) do
    $stdout = Pry.config._orig_stdout
    $stderr = Pry.config._orig_stderr
    PryAuditlog::Logger.log("AUDIT LOG", "Pry session ended")
  end
end
