require_relative '../base_servlet'

class MoveServlet < BaseServlet
  def do_MOVE(request, response)
    init_vars(request, response)

    move_logic
  end

  private

  def move_logic
    if required_headers?(MOVE_HEADERS)
      from = full_path(@headers[:from])
      to   = full_path(@headers[:to])
      if all_correct?(from, to)
        FileUtils.move(from, to)
        create_response
      else
        create_failure_response
      end
    else
      create_failure_response
    end
  end

  def all_correct?(from, to)
    from != to && File.file?(from) && File.exist?(File.dirname(to)) && !@headers[:to].nil?
  end
end
