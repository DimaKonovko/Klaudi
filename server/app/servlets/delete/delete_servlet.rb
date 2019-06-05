require_relative '../base_servlet'

class DeleteServlet < BaseServlet

  def do_DELETE(request, response)
    init_vars(request, response)
    return unless correct_connection?

    delete_logic
  end

  private

  def delete_logic
    if !required_headers?(DELETE_HEADERS)
      resp_body "Uncorrect headers!\n"
      return
    end

    if correct_path_to_file?
      delete_file
    else
      resp_body "Uncorrect path or file does not exists!\n"
    end
  end

  def delete_file
    begin
      File.delete(@path)
      create_response
    rescue
      create_failure_response
    end
  end

end
