module PryAuditlog
  class Logger
    def initialize()
      begin
        @audit_file = File.open(Pry.config.auditlog_file, 'a', 0600).tap { |f| f.sync = true }
      rescue Errno::EACCES
        @audit_file = false
      end
    end

    def log_input(line)
      input_line = "[INPUT] #{line}"
      audit_log(input_line)
    end

    def log_output(line)
      output_line = "[OUTPUT] #{line}"
      audit_log(output_line)
    end

    def log(line)
      audit_log(line)
    end

    def audit_log(line)
      log_line = "[#{Time.now.to_s}] #{line}"
      @audit_file.puts log_line
    end

  end
end