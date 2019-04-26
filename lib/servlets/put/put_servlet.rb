require_relative '../base_servlet'

class PutServlet < BaseServlet
  def do_PUT(request, response)
    init_vars(request, response)

    put_logic
  end

  private

  def put_logic
    required_headers?(PUT_HEADERS) ? add_to_file : create_failure_response
  end

  def add_to_file
    path = full_path(@headers[:path])
    begin
      File.open(path, 'w') do |file|
        file.puts(@body)
      end
      create_response
    rescue
      create_failure_response
    end
  end
end
