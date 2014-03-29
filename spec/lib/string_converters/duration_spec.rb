require 'string_converters/duration'

describe StringConverters::Duration do
  subject { StringConverters::Duration }

  context "#to_seconds" do
    it "converts seconds to seconds" do
      seconds = subject.new("23").to_seconds
      expect(seconds).to eq(23)
    end

    it "converts minutes:seconds to seconds" do
      seconds = subject.new("2:03").to_seconds
      expect(seconds).to eq(123)
    end

    it "converts hours:minutes:seconds to seconds" do
      seconds = subject.new("03:25:45").to_seconds
      expect(seconds).to eq(12345)
    end

    it "accepts durations with leading zeroes" do
      seconds = subject.new("02:03").to_seconds
      expect(seconds).to eq(123)
    end
  end

  context "#duration" do
    it "returns the duration" do
      duration = subject.new("02:03").duration
      expect(duration).to eq("02:03")
    end

    it "raises MalformedDuration error if malformed duration" do
      expect do
        subject.new("foo").to_seconds
      end.to raise_error(StringConverters::MalformedDuration)
    end
  end
end
