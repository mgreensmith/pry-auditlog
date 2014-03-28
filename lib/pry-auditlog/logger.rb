module PryAuditlog
  class Logger
    begin
      @@audit_file = File.open(Pry.config.auditlog_file, 'a', 0600).tap { |f| f.sync = true }
    rescue Errno::EACCES
      @@audit_file = false
    end

    def self.set_prompt(current_prompt)
      @@current_prompt = current_prompt
    end

    def self.log(type, line)
      if type == 'I'
        line = "#{@@current_prompt}#{line}"
      end
      log_line = "[#{Time.now.to_s}] [#{type}] #{line}"
      @@audit_file.puts log_line if @@audit_file
    end

  end
end