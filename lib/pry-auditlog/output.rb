module PryAuditlog
  class Output < StringIO
    attr_writer :_original_output

    def print(line)
      PryAuditlog::Logger.log('O', line)
      @_original_output.print(line)
    end
    alias_method :<<, :print
    alias_method :write, :print
  end
end
