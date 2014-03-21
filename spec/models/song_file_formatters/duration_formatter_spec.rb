require 'spec_helper'

module SongFileFormatters
  describe DurationFormatter do
    it "formats a float as strftime" do
      float_time = 201.143950
      as_strftime = DurationFormatter.as_strftime(float_time)
      expect(as_strftime).to eq("03:21")
    end

    it "formats times greater than or equal to one hour" do
      float_time = 3600.00000
      as_strftime = DurationFormatter.as_strftime(float_time)
      expect(as_strftime).to eq("01:00:00")
    end
  end
end
