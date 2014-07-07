class Pry
  class REPL
    # Read a line of input from the user.
    # @return [String] The line entered by the user.
    # @return [nil] On `<Ctrl-D>`.
    # @return [:control_c] On `<Ctrl+C>`.
    # @return [:no_more_input] On EOF.
    def read
      @indent.reset if pry.eval_string.empty?
      current_prompt = pry.select_prompt
      indentation = pry.config.auto_indent ? @indent.current_prefix : ''

      val = read_line("#{current_prompt}#{indentation}")

      # Return nil for EOF, :no_more_input for error, or :control_c for <Ctrl-C>
      return val unless String === val

      if pry.config.auto_indent
        original_val = "#{indentation}#{val}"
        indented_val = @indent.indent(val)

        if pry.config.correct_indent && Pry::Helpers::BaseHelpers.use_ansi_codes?

          # if we're logging output, send the input line through the original
          # pry output, so that we see it prettified on the TTY.
          if Pry.config.auditlog_log_output
            pry.config.original_output.print @indent.correct_indentation(
              current_prompt, indented_val,
              original_val.length - indented_val.length
            )
            pry.config.original_output.flush
          # Fall back on default behavior, our stuff isn't loaded
          elsif output.tty?
            output.print @indent.correct_indentation(
              current_prompt, indented_val,
              original_val.length - indented_val.length
            )
            output.flush
          end
        end
      else
        indented_val = val
      end

      # send the prompt and log line to our logger.
      if Pry.config.auditlog_log_input
        PryAuditlog::Logger.set_prompt(current_prompt)
        PryAuditlog::Logger.log('I', indented_val)
      end

      indented_val
    end
  end
end
