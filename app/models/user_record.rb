require_relative '../../db/config'
require_relative '../helpers/db_helper'

class UserRecord

  attr_accessor :name, :password, :root

  def initialize(username, password)
    @name = username
    @password = password
    @root = ''
  end

  def save
    helper = DBHelper.new
    if helper.user_exists?(@name)
      puts "User #{@name} already exists"
      return
    end
    connection = helper.connect(USERNAME, DBNAME)
    return if connection.nil?

    helper.exec(connection, "INSERT INTO users (username, password) VALUES ('#{@name}', '#{@password}')")
  end

end
