require_relative 'calculator'

module HowMany
  class App
    @@version = "0.0.1"
    @options = {}

    def self.version
      @@version
    end

    def run(args)
      @options = OptionsParser.parse(args)
      result = if @options.operation == 'till'
                 Calculator.how_many_till(@options.to_units, @options.till_time)
               elsif @options.operation == 'in'
                 Calculator.how_many_in(@options.from_number, @options.from_units, @options.to_units, return_type: @options.type == "integer" ? "integer" : "float")
               end

      puts result
    rescue OptionParser::InvalidArgument, OptionParser::MissingArgument, OptionParser::InvalidOption => exception
      warn exception.message
      warn "For usage information, use -h or --help"
      exit 1
    end
  end
end
