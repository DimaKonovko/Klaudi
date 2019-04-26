require_relative '../base_servlet'

class DeleteServlet < BaseServlet
  def do_DELETE(request, response)
    init_vars(request, response)

    delete_logic
  end

  private

  def delete_logic
    required_headers?(DELETE_HEADERS) ? create_response : create_failure_response
  end

  def create_response
    path = full_path(@headers[:path])
    if File.file?(path)
      File.delete(path)
      create_response
    else
      create_failure_response
    end
    @response
  end
end
