#!/usr/bin/env ruby

require 'pry'

Pry.config.auditlog_enabled = true
Pry.config.auditlog_file = '/pry_audit.log'
require 'pry-auditlog'

Pry.start
