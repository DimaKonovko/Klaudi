class BaseServlet < WEBrick::HTTPServlet::AbstractServlet
  ROOT_PATH = "#{File.absolute_path('.', '../public')}/"
  REQUIRED_POST_HEADERS = %w(path)

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

  def correct_headers?
    headers = @headers.keys.map { |key| key.to_s }
    (headers & REQUIRED_POST_HEADERS).count == REQUIRED_POST_HEADERS.count
  end

end
