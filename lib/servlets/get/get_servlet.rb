require_relative '../base_servlet'

class GetServlet < BaseServlet
  def do_GET(request, response)
    init_vars(request, response)

    get_logic
  end

  private

  def get_logic
    required_headers?(GET_HEADERS) ? create_response : create_failure_response
  end

  def create_response
    path = full_path(@headers[:path])
    if File.file?(path)
      File.open(path, 'r') do |file|
        @response.body = file.read
      end
    else
      create_failure_response
    end
  end
end
