require 'webrick'
require_relative 'servlets/get/get_servlet'
require_relative 'servlets/post/post_servlet'
require_relative 'servlets/put/put_servlet'
require_relative 'servlets/delete/delete_servlet'

servlets = {
  '/get'      => GetServlet,
  '/register' => PostServlet,
  '/put'      => PutServlet,
  '/delete'   => DeleteServlet,
}

config = {
  Port: 1111
}

def start_server(config = {})
  server = WEBrick::HTTPServer.new(config)
  yield server if block_given?
  server.start
end

start_server(config) do |server|
  servlets.each do |path, class_name|
    server.mount(path, class_name)
  end
end
