module SongScopes
  class DurationScope
    def initialize(high: high, low: low)
      @high = high
      @low = low
    end

    def less_than
      SongFile.where("duration < ?", high).map(&:fileable)
    end

    def greater_than
      SongFile.where("duration > ?", low).map(&:fileable)
    end

    def between
      SongFile.where("duration < ? AND duration > ?", high, low).map(&:fileable)
    end

    def high
      to_seconds(@high)
    end

    def low
      to_seconds(@low)
    end

    private
    def to_seconds(time)
      Duration::DurationParse.new(time).to_seconds
    end
  end
end
