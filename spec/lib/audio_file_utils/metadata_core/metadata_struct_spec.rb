require 'audio_file_utils/metadata_core/metadata_struct'

describe AudioFileUtils::MetadataCore::MetadataStruct do
  subject { described_class }

  it "has FilesystemInfo" do
    expect(subject.new).to respond_to(:filename)
    expect(subject.new).to respond_to(:filesize)
    expect(subject.new).to respond_to(:format)
  end

  it "has AudioProperties" do
    expect(subject.new).to respond_to(:bit_rate)
    expect(subject.new).to respond_to(:duration)
  end

  it "has TagAttributes" do
    expect(subject.new).to respond_to(:album)
    expect(subject.new).to respond_to(:artist)
    expect(subject.new).to respond_to(:date)
    expect(subject.new).to respond_to(:genre)
    expect(subject.new).to respond_to(:title)
    expect(subject.new).to respond_to(:track)
  end
end
