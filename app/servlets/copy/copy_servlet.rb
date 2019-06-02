require_relative '../base_servlet'

class CopyServlet < BaseServlet

  def do_COPY(request, response)
    # init_vars(request, response)
    #
    # copy_logic
  end

  private

  # def copy_logic
  #   if required_headers?(COPY_HEADERS)
  #     from = full_path(@headers[:from])
  #     to   = full_path(@headers[:to])
  #     if all_correct?(from, to)
  #       FileUtils.cp(from, to)
  #       create_response
  #     else
  #       create_failure_response
  #     end
  #   else
  #     create_failure_response
  #   end
  # end
  #
  # def all_correct?(from, to)
  #    from != to && File.file?(from) && File.exist?(File.dirname(to)) && !@headers[:to].nil?
  # end

end
