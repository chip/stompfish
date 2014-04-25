require 'audio_file_utils/metadata_core/audio_properties'

describe AudioFileUtils::MetadataCore::AudioProperties do
  subject { described_class }

  context "@taglib" do
    let(:properties) { double(bitrate: 456, length: 123) }
    let(:info)  { subject.new(properties).info }

    it "has a bit_rate" do
      expect(info.bit_rate).to eq(456)
    end

    it "has a duration" do
      expect(info.duration).to eq(123)
    end
  end

  context "@ffprobe" do
    let(:properties) { double(bit_rate: "456", duration: "123", bitrate: nil, length: nil) }
    let(:info)  { subject.new(properties).info }

    it "has a bit_rate" do
      expect(info.bit_rate).to eq(456)
    end

    it "has a duration" do
      expect(info.duration).to eq(123)
    end
  end
end
