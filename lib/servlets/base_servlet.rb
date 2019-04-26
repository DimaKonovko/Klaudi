class BaseServlet < WEBrick::HTTPServlet::AbstractServlet
  ROOT_PATH      = "#{File.absolute_path('.', '../public')}/"
  POST_HEADERS   = %w(path)
  GET_HEADERS    = %w(path)
  PUT_HEADERS    = %w(path)
  DELETE_HEADERS = %w(path)
  MOVE_HEADERS   = %w(from to)
  COPY_HEADERS   = %w(from to)

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

  def required_headers?(required_headers)
    headers = @headers.keys.map { |key| key.to_s }
    (headers & required_headers).count == required_headers.count
  end

  def full_path(path)
    "#{ROOT_PATH}#{path}"
  end

  def create_response
    @response.body = "SUCCESS!\n"
  end

  def create_failure_response
    @response.body = "FAILURE!\n"
  end
end
