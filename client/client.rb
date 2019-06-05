require 'base64'
require 'mechanize'

SERVER = '127.0.0.1'
PORT   = '8080'

POST_URL   = 'http://localhost:1111/register'
GET_URL    = 'http://localhost:1111/get?path=<PATH>'
PUT_URL    = 'http://localhost:1111/put?path=<PATH>'
DELETE_URL = 'http://localhost:1111/delete?path=<PATH>'

def sign_in
  print 'Login: '
  @login = gets.chomp
  print 'Password: '
  @password = gets.chomp
  if @login =='' || @password == ''
    puts 'Uncorrect password or login'
    return
  end

  headers = { 'username'=>@login, 'password'=>@password }
  result = @agent.post(POST_URL, [], headers)
  puts result.body
end

def create_token
  "Basic #{Base64::encode64("#{@login}:#{@password}").strip}"
end

def download_file
  print "\nPath: "
  path = gets.chomp
  url = GET_URL.sub('<PATH>', path)
  headers = { 'authorization'=>create_token }
  response = @agent.get(url, [], nil, headers)
  if response.header['status'] == 'downloaded'
    print 'Path to save: '
    path_to_save = gets.chomp
    begin
      File.open(path_to_save, 'w') do |file|
        file.puts response.body
      end
    rescue
      puts 'Uncorrect path to save!'
    end
  else
    puts response.body
  end
end

def load_file
  print "\nPath: "
  path = gets.chomp
  url = PUT_URL.sub('<PATH>', path)
  begin
    data = File.open(path, 'r').read
  rescue
    puts 'Uncorrect path to file'
    return
  end
  headers = { 'authorization'=>create_token }
  response = @agent.put(url, data, headers)
  puts response.body
end

def delete_file
  print "\nPath: "
  path = gets.chomp
  url = DELETE_URL.sub('<PATH>', path)
  headers = { 'authorization'=>create_token }
  response = @agent.delete(url, {}, headers)
  puts response.body
end

@agent = Mechanize.new

loop do
  puts '----------------------------------'
  puts '  Choose:'
  puts '   1. SIGN IN or LOG IN'
  puts '   2. Download file'
  puts '   3. Upload file'
  puts '   4. Delete file'
  puts '   0. Leave Klaudi'
  print '                 Your choice: '
  choice = gets.chomp
  puts "\n"
  case choice.to_i
  when 1
    sign_in
  when 2
    download_file
  when 3
    load_file
  when 4
    delete_file
  when 0
    puts 'See you again! Buy :('
    break
  else
    puts 'Uncorrect input'
  end
end