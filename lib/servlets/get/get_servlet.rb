require_relative '../base_servlet'

class GetServlet < BaseServlet
  def do_GET(request, response)
    init_vars(request, response)

    get_logic
  end

  private

  def get_logic
    correct_headers?(REQUIRED_GET_HEADERS) ? create_response : create_failure_response
  end

  def create_response
    path = full_path(@headers[:path])
    if File.file?(path)

      File.open(path, 'r') do |file|
        @response.body = file.read
      end
    end
    @response
  end

  def create_failure_response
    @response.body = "ERROR!"
    @response
  end
end
