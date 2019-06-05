require_relative '../base_servlet'

class GetServlet < BaseServlet

  def do_GET(request, response)
    init_vars(request, response)
    return unless correct_connection?

    get_logic
  end

  private

  def get_logic
    if !required_headers?(GET_HEADERS)
      resp_body "Uncorrect headers!\n"
      return
    end

    if show_root?
      resp_body(what_in_folder("#{$user.root}/*").join("\n"))
    elsif show_dir?
      resp_body(what_in_folder("#{create_path}/*").join("\n"))
    elsif download?
      download_file
    else
      create_failure_response
    end
  end

  def show_root?
    @headers[:path].nil? || @headers[:path].include?('root')
  end

  def show_dir?
    correct_path_to_dir?
  end

  def download?
    correct_path_to_file?
  end

  def download_file
    File.open(@path, 'r') do |file|
      resp_body file.read
    end
    set_status('downloaded')
  end

end
