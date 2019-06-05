require_relative '../../db/config'

class DBHelper

  def connect(username, db_name)
    begin
      connection = PG.connect user: username, dbname: db_name
    rescue PG::Error => e
      puts e.message
      return
    end
    connection
  end

  def exec(connection, command)
    begin
     connection.exec command
    rescue PG::Error => e
     puts e.message
     return
    end
  end

  def user_exists?(username)
    connection = connect(USERNAME, DBNAME)
    matches = connection.exec "SELECT * FROM users WHERE (username = '#{username}')"
    connection.close
    !matches.values.empty?
  end

  def correct_password?(username, password)
    connection = connect(USERNAME, DBNAME)
    matches = connection.exec "SELECT * FROM users WHERE (username = '#{username}' AND password = '#{password}')"
    connection.close
    !matches.values.empty?
  end

end
