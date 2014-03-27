module PryAuditlog
  class Logger
    begin
      @@audit_file = File.open(Pry.config.auditlog_file, 'a', 0600).tap { |f| f.sync = true }
    rescue Errno::EACCES
      @@audit_file = false
    end


    def self.log_input(line)
      input_line = "[INPUT] #{line}"
      self.audit_log(input_line)
    end

    def self.log_output(line)
      output_line = "[OUTPUT] #{line}"
      self.audit_log(output_line)
    end

    def self.log_eval(line)
      eval_line = "[EVAL] #{line}"
      self.audit_log(eval_line)
    end

    def self.log_banner(line)
      output_line = "***** #{line} *****"
      self.audit_log(output_line)
    end

    def self.log(line)
      self.audit_log(line)
    end

    def self.audit_log(line)
      log_line = "[#{Time.now.to_s}] #{line}"
      @@audit_file.puts log_line if @@audit_file
    end

  end
end