require 'audio_file_utils/metadata'

describe AudioFileUtils::Metadata do
  subject { AudioFileUtils::Metadata }

  it "returns a FileMetadata object" do
    fileref = double("fileref")

    expect(TagLib::FileRef).
      to receive(:open).
      with("fake.txt").
      and_yield(fileref)

    expect(fileref).
      to receive(:tag).
      and_return(true)

    expect(fileref).
      to receive(:audio_properties).
      and_return(true)

    expect(AudioFileUtils::MetadataCore::MetadataStruct).
      to receive(:process!)

    tags = subject.new("fake.txt").tags
  end

  it "uses Ffprobe as a backup if TagLib fails" do
    fileref = double("fileref")
    ffprobe = double("ffprobe")

    expect(TagLib::FileRef).
      to receive(:open).
      with("fake.txt").
      and_yield(fileref)

    expect(fileref).
      to receive(:tag).
      and_return(false)

    expect(fileref).
      to receive(:audio_properties).
      and_return(false)

    expect(AudioFileUtils::MetadataCore::Ffprobe).
      to receive(:new).
      with("fake.txt").
      and_return(ffprobe)

    expect(ffprobe).to receive(:tags)
    expect(ffprobe).to receive(:properties)

    expect(AudioFileUtils::MetadataCore::MetadataStruct).
      to receive(:process!)

    subject.tags("fake.txt")
  end
end
