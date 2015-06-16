module PryAuditlog
  class Logger
    attr_writer :audit_file, :prompt, :session_token

    @prompt = ''
    @session_token = ''

    begin
      if Pry.config.auditlog_file
        @audit_file = File.open(Pry.config.auditlog_file, 'a', 0600).tap { |f| f.sync = true }
      end
    rescue Errno::EACCES, Errno::ENOENT
      @audit_file = nil
    end

    def self.log(type, line)
      line = "#{@prompt}#{line}" if type == 'I'
      log_line = "[#{Time.now}][#{@session_token}][#{type}] #{line}"
      @audit_file.puts log_line if @audit_file && !line.strip.empty?
    end
  end
end
