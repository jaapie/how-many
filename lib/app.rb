# frozen_string_literal: true

require_relative 'calculator'

module HowMany
  # a class representing the app
  class App
    VERSION = '0.0.1'
    @options = {}

    def self.version
      VERSION
    end

    def run(args)
      @options = OptionsParser.parse(args)
      case @options.operation
      when 'till' then puts Calculator.how_many_till(@options.to_units, @options.till_time)
      when 'in' then puts Calculator.how_many_in(@options.from_number, @options.from_units, @options.to_units,
                                                 return_type: @options.type == 'integer' ? 'integer' : 'float')
      else puts "error: unsupported operation \"#{result}\""
      end
    rescue OptionParser::InvalidArgument, OptionParser::MissingArgument, OptionParser::InvalidOption => e
      warn e.message
      warn 'For usage information, use -h or --help'
      exit 1
    end
  end
end
