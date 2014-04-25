require 'audio_file_utils/metadata_core/tag_attributes'

describe AudioFileUtils::MetadataCore::TagAttributes do
  subject { described_class }

  context "@taglib" do
    let(:info) { subject.new(tags).info }

    let(:tags) do
      double(album: "egg", artist: "can", year: 1975,
             genre: "cake", title: "milk", track: 1)
    end

    it "has an album" do
      expect(info.album).to eq("egg")
    end

    it "has an artist" do
      expect(info.artist).to eq("can")
    end

    it "has an date" do
      expect(info.date).to eq(1975)
    end

    it "has an genre" do
      expect(info.genre).to eq("cake")
    end

    it "has an title" do
      expect(info.title).to eq("milk")
    end

    it "has an track" do
      expect(info.track).to eq(1)
    end
  end

  context "@ffprobe" do
    let(:info) { subject.new(tags).info }

    let(:tags) do
      double(album: "egg", artist: "can", year: nil,
             genre: "cake", title: "milk", track: "1",
             date: "1975")
    end

    it "has an date" do
      expect(info.date).to eq(1975)
    end

    it "has an track" do
      expect(info.track).to eq(1)
    end
  end
end
