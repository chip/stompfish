module Formatters
  class Duration
    HOURS = "%H:%M:%S"
    MINUTES = "%M:%S"
    ONE_HOUR = 3600

    attr_reader :duration

    def initialize(duration)
      @duration = duration
    end

    def as_strftime
      if duration >= ONE_HOUR
        format_time(HOURS)
      else
        format_time(MINUTES)
      end
    end

    def self.as_strftime(duration)
      new(duration).as_strftime
    end

    private
    def format_time(strf)
      Time.at(duration).gmtime.strftime(strf)
    end
  end
end
