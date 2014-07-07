module PryAuditlog
  class Logger
    @@current_prompt = ''
    @@session_token = ''
    begin
      if Pry.config.auditlog_file
        @@audit_file = File.open(Pry.config.auditlog_file, 'a', 0600).tap { |f| f.sync = true }
      else
        @@audit_file = false
      end
    rescue Errno::EACCES, Errno::ENOENT
      @@audit_file = false
    end

    def self.set_session_token(token)
      @@session_token = token
    end

    def self.set_prompt(current_prompt)
      @@current_prompt = current_prompt
    end

    def self.log(type, line)
      line = "#{@@current_prompt}#{line}" if type == 'I'
      log_line = "[#{Time.now.to_s}][#{@@session_token}][#{type}] #{line}"
      @@audit_file.puts log_line if @@audit_file && !line.strip.empty?
    end
  end
end
