# frozen_string_literal: true

require 'time'
require 'optparse'

module HowMany
  # parses options
  class OptionsParser
    # app options
    class Options
      attr_accessor :type, :to_units, :operation, :from_units, :from_number, :till_time

      def initialize
        self.type = 'float'
        self.to_units = 'second'
        self.operation = 'in'
        self.from_units = 'year'
        self.from_number = 1
        self.till_time = '10:00pm'
      end
    end

    def self.parse_positional_parameters(args)
      units_pattern = /(second|minute|hour|day|week|fortnight|month|year)/

      @options ||= Options.new

      @options.to_units = args.shift
      raise OptionParser::InvalidArgument, 'to units' unless @options.to_units.match units_pattern

      @options.operation = args.shift
      raise OptionParser::InvalidArgument, 'operation' unless @options.operation.match(/(in|till)/)

      case @options.operation
      when 'in'
        begin
          @options.from_number = args.shift.to_f
          raise OptionParser::InvalidArgument, 'number' unless @options.from_number > 0.0

          @options.from_units = args.shift
          raise OptionParser::InvalidArgument, 'from units' unless @options.from_units.match units_pattern
        end
      when 'till'
        begin
          t = args.shift
          @options.till_time = Time.parse(t)
        rescue ArgumentError
          raise ArgumentError, "#{t} is not a valid time/date string"
        end
      end

      # strip the 's' from the end of the unit word
      # unless @options.to_units.match(/.*s$/)
      #   @options.to_units = @options.to_units.slice 0, @options.to_units.length - 1
      # end

      # remove the trailing s on plural time period names
      if @options.from_units.match(/.*s$/)
        @options.from_units = @options.from_units.slice 0, @options.from_units.length - 1
      end

      @options.to_units = @options.to_units.slice 0, @options.to_units.length - 1 if @options.to_units.match(/.*s$/)
    end

    @banner_text = <<~USAGE
      Usage:

      ./how-many <units> in NUMBER <units> [options]
      ./how-many <units> till <time|date|datetime> [options]

      units       is one of the following: seconds, minutes, days, weeks,
                  months, or years. The first unit specified is usually the smaller.

      in          unit conversion from the first units specified to the second. For
                  example, specifying ./howmany seconds in 24 hours will tell you
                  how many seconds are in 24 hours.

      till        calculate how many units till time/datetime. For example,
                  specifying ./howmany days till 2020/08/10 will tell you how many
                  days it is until the 8th of October 2020.

      time        is a time specified as hh:mm:ss (am|pm) in 12h or 24h

      date        is a date, specified in whatever your local date format is.
                  Remember to escape special shell chars (if any) and spaces, or
                  just surround your date with quotes.

      datetime    is a datetime, with date formatted as described as above,
                  and time formatted as described above also.
    USAGE

    def self.parse(args)
      @options = Options.new

      args.push('-h') if args.empty?

      parse_positional_parameters args unless args[0].match(/^-/)

      @parser ||= OptionParser.new do |parser|
        parser.banner = @banner_text
        parser.separator ''
        parser.separator 'Options:'

        parser.on('-tTYPE', '--type=TYPE', %w[float integer],
                  'output type, f for float (default), i for integer') do |type|
                    @options.type = type
                  end

        parser.separator ''
        parser.separator 'Metadata Options:'
        parser.on_tail('-h', '--help', 'show this message') do
          puts parser
          exit
        end
        parser.on_tail('-V', '--version', 'show program version') do
          puts App.version
          exit
        end
      end

      @parser.parse!(args)

      @options
    end
  end
end
