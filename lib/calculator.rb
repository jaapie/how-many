module HowMany
  class DateTimeInPastError < StandardError
  end

  class UnrecognisedUnitError < StandardError
  end

  class Calculator
    def self.how_many_till(to_units, till_time, return_type: "float")
      answer = till_time - Time.now
      raise DateTimeInPastError.new "error: #{till_time} is in the past" if answer < 0
      self.how_many_in(answer, "second", to_units, return_type: return_type)
    end

    def self.how_many_in(from_number, from_units, to_units, return_type: "float")
      seconds_in = {
        "second" => 1.0,
        "minute" => 60.0,
        "hour" => (60.0*60),
        "day" => (3600.0*24),
        "week" => (3600.0*24*7),
        "fortnight" => (3600.0*24*7*2),
        "month" => (3600*24*7*(52.1429/12)),
        "year" => (3600*24*7*52.1429)
      }

      raise UnrecognisedUnitError.new "error: \"#{from_units}\" is not a recognised unit of time" if seconds_in[from_units] == nil
      raise UnrecognisedUnitError.new "error: \"#{to_units}\" is not a recognised unit of time" if seconds_in[to_units] == nil

      # calculate the result in seconds
      result_seconds = from_number * seconds_in[from_units]

      # unless the units wanted are not secons, display the result,
      # otherwise calculate the result in whatever units are wanted
      if to_units == "second"
        result = result_seconds
      else
        result = result_seconds / seconds_in[to_units]
      end

      return_type == "float" ? result.to_f : result.round
    end
  end
end
