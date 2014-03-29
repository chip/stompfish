module StringConverters
  class Duration
    def initialize(duration)
      @duration = duration
    end

    def duration
      @duration.to_i > 0 or raise MalformedDuration
      @duration
    end

    def to_seconds
      hours + minutes + seconds
    end

    private
    def seconds
      time_pieces[:sec]
    end

    def minutes
      time_pieces[:min] * 60
    end

    def hours
      time_pieces[:hour] * 3600
    end

    def time_pieces
      @time ||= Hash[sec: parsed[0], min: parsed[1].to_i, hour: parsed[2].to_i]
    end

    def parsed
      @split ||= duration.split(":").map { |t| t.to_i }.reverse
    end
  end

  MalformedDuration = Class.new(StandardError)
end
