class Pry
  class History
    
    #attr_accessor :original_pusher

    # we monkeypatch 'load' to 
    # 1. Overwrite @pusher with our own audit_and_push method
    # 2. ensure that we don't write the entire history into the audit log on load.
    def load
      @original_pusher ||= @pusher
      @pusher = method(:audit_and_push) if Pry.config.auditlog_enabled
      @loader.call do |line|
        if Pry.config.auditlog_enabled
          @original_pusher.call(line.chomp)
        else
          @pusher.call(line.chomp)
        end
        @history << line.chomp
      end
      @saved_lines = @original_lines = @history.length
    end

    # new method
    def audit_and_push(line)
      PryAuditlog::Logger.log("I", line)
      @original_pusher.call(line)
    end

  end
end
