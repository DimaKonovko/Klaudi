require_relative '../base_servlet'

class PostServlet < BaseServlet
  def do_POST(request, response)
    init_vars(request, response)

    post_logic
  end

  private

  def post_logic
    required_headers?(POST_HEADERS) ? add_to_file : create_failure_response
  end

  def add_to_file
    path = full_path(@headers[:path])
    if File.file?(path)
      File.open(path, 'a') do |file|
        file.puts(@body)
      end
      create_response
    else
      create_failure_response
    end
  end
end
