module PryAuditlog
  class Output < StringIO

    def set_original_output(orig)
      @original_output = orig
    end

    def puts(line)
      PryAuditlog::Logger.log("OUTPUT", line)
      @original_output.puts(line)
    end
  end
end
