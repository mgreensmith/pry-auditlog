# PryAuditlog

PryAuditlog is a plugin for the [Pry](http://pry.github.com) REPL that enables logging of any combination of Pry input and output to a configured audit log file.

It modifies the `read` method of the REPL class to read input statements to Pry, and it inserts itself into the `output` mechanism to scrape a copy of all emitted data. It also redirects `$stdout` and `$stderr` during the Pry session in order to capture all output emitted from any `puts` or similar statements. 

All output data is forwarded to the original configured `Pry.config.output` mechanism after logging, and this plugin should (hopefully) respect any configured outputter.

The log file location is configurable, and the choice of logging input statements, output statements or both (the default) is configurable.

## Installation

    $ gem install pry-auditlog

## Usage

Set appropriate config values and then require the plugin in your `.pryrc` or any other location where you configure Pry.

```
# The auditlog must be explicitly enabled
Pry.config.auditlog_enabled = true         # default: false

# Optional path to audit log destination
Pry.config.auditlog_file = '/path/to/file' # default: '/dev/null'

# We log both input and output by default
Pry.config.auditlog_log_input = false    # default: true
Pry.config.auditlog_log_output = false   # default: true

# Set all config values *before* requiring the plugin
require 'pry-auditlog'
```

### Author

Matt Greensmith for [Cozy](http://www.cozy.co)