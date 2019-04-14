class MoveServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_MOVE(request, response)
    parse_request(request)
    create_response(response)
  end

  private

  def parse_request(request)

  end

  def create_response(response)
    response.body = "Hi from MOVE\n"
    response
  end
end
