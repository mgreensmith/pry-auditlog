require 'pry'
require 'pry-auditlog/version'

Pry.config.auditlog.enabled ||= false
Pry.config.auditlog.file ||= nil

class Pry
  class History
    
    @auditor = method(:save_to_audit_file)

    # Add a line to the input history, ignoring blank and duplicate lines.
    # @param [String] line
    # @return [String] The same line that was passed in
    def push(line)
      unless line.empty? || (@history.last && line == @history.last)
        @pusher.call(line)
        @history << line
        @saver.call(line) if Pry.config.history.should_save
        @auditor.call(line) if Pry.config.auditlog.enabled
      end
      line
    end

    private

    def save_to_audit_file(line)
      audit_file.puts line if audit_file
    end

    # the audit file, opened for appending
    def audit_file
      if defined?(@audit_file)
        @audit_file
      else
        @audit_file = File.open(Pry.config.auditlog.file, 'a', 0600).tap { |f| f.sync = true }
      end
    rescue Errno::EACCES
      @audit_file = false
    end
    
  end
end