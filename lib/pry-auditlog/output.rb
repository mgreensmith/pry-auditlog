module PryAuditlog
  class Output < StringIO
    def _set_original_output(orig)
      @original_output = orig
    end

    def print(line)
      PryAuditlog::Logger.log('O', line)
      @original_output.print(line)
    end
    alias_method :<<, :print
    alias_method :write, :print
  end
end
