class Pry
  class History
    
    attr_accessor :original_pusher

    # we monkeypatch 'load' to ensure that we don't dump the entire history
    # into the auditlog on startup.
    def load
      @loader.call do |line|
        if Pry.config.auditlog_enabled
          @original_pusher.call(line.chomp)
        else
          @pusher.call(line.chomp)
        end
        @history << line.chomp
      end
      @saved_lines = @original_lines = @history.length

      PryAuditlog::Logger.log_banner("New Pry session started") if Pry.config.auditlog_enabled
    end

    # new methods for use by PryAuditlog

    def load_auditor
      @original_pusher = @pusher
      @pusher = method(:audit_and_push_to_readline) if Pry.config.auditlog_enabled
    end

    def audit_and_push_to_readline(line)
      PryAuditlog::Logger.log_input(line)
      @original_pusher.call(line)
    end

  end
end