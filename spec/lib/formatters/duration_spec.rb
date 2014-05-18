require 'formatters/duration'

module Formatters
  describe Duration do
    it "formats a float as strftime" do
      float_time = 201.143950
      as_strftime = Duration.as_strftime(float_time)
      expect(as_strftime).to eq("03:21")
    end

    it "formats times greater than or equal to one hour" do
      float_time = 3600.00000
      as_strftime = Duration.as_strftime(float_time)
      expect(as_strftime).to eq("01:00:00")
    end

    it "raises error if time is empty" do
      expect do
        Duration.as_strftime("")
      end.to raise_error(DurationError, "duration must be a number")
    end

    it "raises error if time is nil" do
      expect do
        Duration.as_strftime(nil)
      end.to raise_error(DurationError, "duration must be a number")
    end

    it "raises error if time is string" do
      expect do
        Duration.as_strftime("foo")
      end.to raise_error(DurationError, "duration must be a number")
    end
  end
end
