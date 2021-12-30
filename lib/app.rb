module HowMany
  class App
    @@version = "0.0.1"
    @options = {}

    def self.version
      @@version
    end

    def do_calculations
      raise "till operation not yet implemented" if @options.operation == "till"

      seconds_in = {
        "second" => 1,
        "minute" => 60,
        "hour" => (60*60),
        "day" => (3600*24),
        "week" => (3600*24*7),
        "fortnight" => (3600*24*7*2),
        "month" => (3600*24*7*(52.1429/12)),
        "year" => (3600*24*7*52.1429)
      }

      # calculate the result in seconds
      result_seconds = @options.from_number * (seconds_in[@options.from_units])

      # unless the units wanted are not secons, display the result,
      # otherwise calculate the result in whatever units are wanted
      unless @options.to_units != "seconds"
        result = result_seconds
      else
        result = result_seconds / (seconds_in[@options.to_units])
      end

      STDOUT.puts @options.type == "integer" ? result.round : result
    end

    def run(args)
      begin
        @options = OptionsParser.parse(args)
      rescue OptionParser::InvalidArgument, OptionParser::MissingArgument, OptionParser::InvalidOption => exception
        warn exception.message
        warn "For usage information, use -h or --help"
        exit 1
      end
      do_calculations
    end
  end
end
