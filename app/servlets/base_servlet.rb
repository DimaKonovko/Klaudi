require 'base64'
require_relative '../helpers/db_helper'
require_relative '../../app/models/user_record'

class BaseServlet < WEBrick::HTTPServlet::AbstractServlet

  ROOT_PATH      = "#{File.absolute_path('.', '../public')}".freeze

  POST_HEADERS   = %w(path)
  GET_HEADERS    = %w(path)
  PUT_HEADERS    = %w(path)
  DELETE_HEADERS = %w(path)
  MOVE_HEADERS   = %w(from to)
  COPY_HEADERS   = %w(from to)

  def init_vars(request, response)
    @request  = request
    @response = response
    @headers  = get_headers
    @path     = create_path if !$user.nil?
  end

  def get_headers
    hash = {}
    if !@request.query_string.nil?
      @request.query_string.split('&').each do |param|
        head, value = param.split('=')
        hash[head.to_sym] = value
      end
    end
    hash
  end

  def request_body
    @request.body
  end

  def required_headers?(required_headers)
    headers = @headers.keys.map { |key| key.to_s }
    (headers & required_headers).count == required_headers.count
  end

  def create_response
    resp_body "SUCCESS!\n"
  end

  def create_failure_response
    resp_body "FAILURE!\n"
  end

  def req_value(field)
    @request.header[field].first
  end

  def resp_body(msg)
    @response.body = msg
  end

  def correct_token?
    @request.header['authorization'].first == "Basic #{Base64::encode64("#{$user.name}:#{$user.password}").strip}"
  end

  def correct_path?
    @path.include?($user.name)
  end

  def authorized?
    !$user.nil?
  end

  def correct_connection?
    if !authorized?
      resp_body "You are not logged in!\n"
      return false
    end
    if !correct_token?
      resp_body "Uncorrect token!\n"
      return false
    end
    true
  end

  def correct_path_to_file?
    File.file?(@path)
  end

  def correct_path_to_dir?
    Dir.exist?(@path)
  end

  def create_path
    "#{$user.root}/#{@headers[:path]}"
  end


  def create_dirs_if_needed
    path = File.dirname(@path)
    unless File.directory?(path)
      FileUtils.mkdir(path)
    end
  end

  def what_in_folder(path)
    Dir[path].map { |elm| elm.sub(path.sub('*', ''), '') }
  end

end
