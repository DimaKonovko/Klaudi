class PutServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_PUT(request, response)
    parse_request(request)
    create_response(response)
  end

  private

  def parse_request(request)

  end

  def create_response(response)
    response.body = "Hi from PUT\n"
    response
  end
end