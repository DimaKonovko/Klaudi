require_relative '../base_servlet'

class PostServlet < BaseServlet

  def do_POST(request, response)
    init_vars(request, response)
    init_connection
    post_logic
  end

  private

  def init_connection
    username = req_value('username')
    password = req_value('password')
    if username.nil? || password.nil?
      resp_body "Uncorrect data\n"
      return
    end

    $user      = UserRecord.new(username, password)
    $user.root = "#{ROOT_PATH}/#{$user.name}".freeze
  end

  def post_logic
    helper     = DBHelper.new
    connection = helper.connect(USERNAME, DBNAME)
    return if connection.nil?

    if helper.user_exists?($user.name)
      if helper.correct_password?($user.name, $user.password)
        resp_body "Welcome back, #{$user.name}!\n"
      else
        resp_body "Uncorrect password, #{$user.name}!\n"
      end
    else
      $user.save
      resp_body "Welcome to Klaudi, #{$user.name}!\n"
      create_folder
    end
  end

  def create_folder
    FileUtils.mkdir("#{ROOT_PATH}/#{$user.name}")
  end

end
