require 'pry'
require 'pry-auditlog/version'
require 'pry-auditlog/logger'

Pry.config.auditlog_enabled ||= false
Pry.config.auditlog_file ||= nil

require 'ext/pry/history'

Pry.history.load_auditor