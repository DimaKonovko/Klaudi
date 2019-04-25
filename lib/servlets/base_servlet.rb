class BaseServlet < WEBrick::HTTPServlet::AbstractServlet
  ROOT_PATH = "#{File.absolute_path('.', '../public')}/"
  REQUIRED_POST_HEADERS = %w(path)
  REQUIRED_GET_HEADERS  = %w(path)

  def init_vars(request, response)
    @request  = request
    @response = response
    @headers  = headers_from(request)
    @body     = body_from(request)
  end

  def headers_from(request)
    hash = {}
    request.query_string.split('&').each do |param|
      head, value = param.split('=')
      hash[head.to_sym] = value
    end
    hash
  end

  def body_from(request)
    request.body
  end

  def correct_headers?(required_headers)
    headers = @headers.keys.map { |key| key.to_s }
    (headers & required_headers).count == required_headers.count
  end

  def full_path(path)
    "#{ROOT_PATH}#{path}"
  end
end
