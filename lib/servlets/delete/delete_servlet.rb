class DeleteServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_DELETE(request, response)
    parse_request(request)
    create_response(response)
  end

  private

  def parse_request(request)

  end

  def create_response(response)
    response.body = "Hi from DELETE\n"
    response
  end
end