require_relative '../base_servlet'

class PostServlet < BaseServlet
  def do_POST(request, response)
    @request  = request
    @response = response
    @headers  = headers_from request
    @body     = body_from    request

    post_logic
  end

  private

  def post_logic
    add_to_file if correct_headers?
  end

  def add_to_file
    full_path = "#{ROOT_PATH}#{@headers[:path]}"
    begin
      File.open(full_path, 'ab') do |file|
        file.puts(@body)
      end
    rescue
      create_response
    end
  end

  def create_response
    @response.body = "ERROR! Uncorrect path!"
    @response
  end
end