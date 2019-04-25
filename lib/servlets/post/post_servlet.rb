require_relative '../base_servlet'

class PostServlet < BaseServlet
  def do_POST(request, response)
    init_vars(request, response)

    post_logic
  end

  private

  def post_logic
    correct_headers?(REQUIRED_POST_HEADERS) ? add_to_file : create_failure_response
  end

  def add_to_file
    path = full_path(@headers[:path])
    begin
      File.open(path, 'ab') do |file|
        file.puts(@body)
      end
      create_response
    rescue
      create_failure_response
    end
  end

  def create_response
    @response.body = "SUCCESS!"
    @response
  end

  def create_failure_response
    @response.body = "FAILURE!"
    @response
  end
end