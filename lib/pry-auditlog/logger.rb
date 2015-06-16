module PryAuditlog
  class Logger
    class << self
      attr_accessor :audit_file, :prompt, :session_token
    end

    @prompt = ''
    @session_token = ''

    begin
      if Pry.config.auditlog_file
        @audit_file = File.open(File.expand_path(Pry.config.auditlog_file), 'a', Pry.config.auditlog_file_mode).tap { |f| f.sync = true }
      end
    rescue Errno::EACCES, Errno::ENOENT => e
      Pry.output.print "Failed to open audit log file, audit logging is disabled: #{e.message}\n"
      @audit_file = nil
    end

    def self.log(type, line)
      line = "#{@prompt}#{line}" if type == 'I'
      log_line = "[#{Time.now}][#{@session_token}][#{type}] #{line}"
      @audit_file.puts log_line if @audit_file && !line.strip.empty?
    end
  end
end
