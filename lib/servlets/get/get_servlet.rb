class GetServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    parse_request(request)
    create_response(response)
  end

  private

  def parse_request(request)

  end

  def create_response(response)
    response.body = "Hi from GET\n"
    response
  end
end