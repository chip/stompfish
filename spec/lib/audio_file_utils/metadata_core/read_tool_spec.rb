require 'audio_file_utils/metadata_core/read_tool'

describe AudioFileUtils::MetadataCore::ReadTool do
  subject { described_class }

  let(:audio_props) { double("audio_props") }
  let(:ffprobe) { double("ffrobe") }
  let(:file) { "spec/fixtures/17 More Than A Mouthful.mp3" }
  let(:props) { double("props") }
  let(:ref) { double("ref") }
  let(:tag_attrs) { double("tag_attrs") }
  let(:tags) { double("tags") }

  it "returns tags and properties" do
    read = subject.new(file).read
    expect(read).
      to match_array([319, 46, "Nu.wav Hallucinations", "Nmesh",
                      2013, "Vaporwave", "More Than A Mouthful", 17])
  end

  it "uses ffprobe as backup" do
    expect(TagLib::FileRef).
      to receive(:open).
      with("spec/fixtures/17 More Than A Mouthful.mp3").
      and_yield(ref)

    expect(ref).
      to receive(:audio_properties).
      and_return(nil)

    expect(AudioFileUtils::MetadataCore::Ffprobe).
      to receive(:new).
      with("spec/fixtures/17 More Than A Mouthful.mp3").
      and_return(ffprobe)

    expect(ffprobe).
      to receive(:properties).
      and_return(props)

    expect(ref).
      to receive(:tag).
      and_return(nil)

    expect(ffprobe).
      to receive(:tags).
      and_return(tags)

    expect(AudioFileUtils::MetadataCore::AudioProperties).
      to receive(:new).
      with(props).
      and_return(audio_props)

    expect(audio_props).to receive(:info)

    expect(AudioFileUtils::MetadataCore::TagAttributes).
      to receive(:new).
      with(tags).
      and_return(tag_attrs)

    expect(tag_attrs).to receive(:info)

    subject.new(file).read
  end
end
