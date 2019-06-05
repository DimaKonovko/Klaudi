require_relative '../base_servlet'

class PutServlet < BaseServlet

  def do_PUT(request, response)
    init_vars(request, response)
    return unless correct_connection?

    put_logic
  end

  private

  def put_logic
    if !required_headers?(PUT_HEADERS)
      resp_body "Uncorrect headers!\n"
      return
    end

    create_dirs_if_needed
    load_file
  end

  def load_file
    begin
      File.open(@path, 'w') do |file|
        file.puts request_body
      end
    rescue
      create_failure_response
    end
  end

end
