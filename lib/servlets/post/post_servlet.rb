class PostServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)
    parse_request(request)
    create_response(response)
  end

  private

  def parse_request(request)

  end

  def create_response(response)
    response.body = "Hi from POST\n"
    response
  end
end