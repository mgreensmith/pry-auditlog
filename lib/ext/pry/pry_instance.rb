class Pry
  # we monkeypatch retrieve_line to send the current prompt string to the logger

  alias original_retrieve_line retrieve_line

  def retrieve_line(eval_string, target)
    current_prompt = select_prompt(eval_string, target)
    PryAuditlog::Logger.set_prompt(current_prompt)
    original_retrieve_line(eval_string, target)
  end
end
