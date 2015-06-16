require 'pry'
require 'pry-auditlog/version'

Pry.config.auditlog_enabled = false unless defined?(Pry.config.auditlog_enabled)
Pry.config.auditlog_file = '/dev/null' unless defined?(Pry.config.auditlog_file)
Pry.config.auditlog_log_input = true unless defined?(Pry.config.auditlog_log_input)
Pry.config.auditlog_log_output = true unless defined?(Pry.config.auditlog_log_output)

if Pry.config.auditlog_enabled
  require 'pry-auditlog/logger'
  require 'pry-auditlog/output'
  require 'ext/pry/repl'

  if Pry.config.auditlog_log_output
    Pry.config._orig_stdout = $stdout
    Pry.config._orig_stderr = $stderr

    Pry.config.original_output = Pry.config.output
    Pry.config.output = PryAuditlog::Output.new
    Pry.config.output._set_original_output(Pry.config.original_output)
  end

  local_hooks = Pry::Hooks.new

  local_hooks.add_hook(:before_session, :prepare_auditlog) do
    $stdout = $stderr = Pry.config.output if Pry.config.auditlog_log_output
    PryAuditlog::Logger.session_token(Time.now.to_i)
    PryAuditlog::Logger.log('AUDIT LOG', 'Pry session started')
  end

  local_hooks.add_hook(:after_session, :clean_up_auditlog) do
    if Pry.config.auditlog_log_output
      $stdout = Pry.config._orig_stdout
      $stderr = Pry.config._orig_stderr
    end
    PryAuditlog::Logger.log('AUDIT LOG', 'Pry session ended')
  end

  Pry.config.hooks = local_hooks
end
