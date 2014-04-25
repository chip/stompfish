require 'audio_file_utils/metadata'

describe AudioFileUtils::Metadata do
  subject { described_class }

  context "#tags" do
    let(:tags) { subject.new(filepath).tags }
    let(:filepath) { "spec/fixtures/17 More Than A Mouthful.mp3" }

    it "returns a MetadataStruct for @file" do
      expect(tags).to be_a(AudioFileUtils::MetadataCore::MetadataStruct)
    end

    it "contains FilesystemInformation" do
      expect(tags.filename).to eq("spec/fixtures/17 More Than A Mouthful.mp3")
      expect(tags.filesize).to eq(1856841)
      expect(tags.format).to eq("mp3")
    end

    it "contains AudioProperties" do
      expect(tags.duration).to eq(46)
      expect(tags.bit_rate).to eq(319)
    end

    it "contains TagAttributes" do
      expect(tags.album).to eq("Nu.wav Hallucinations")
      expect(tags.artist).to eq("Nmesh")
      expect(tags.date).to eq(2013)
      expect(tags.genre).to eq("Vaporwave")
      expect(tags.title).to eq("More Than A Mouthful")
      expect(tags.track).to eq(17)
    end
  end
end
