require 'multimedia_tools/metadata/read'

describe MultimediaTools::Metadata::Read do
  subject { MultimediaTools::Metadata::Read }

  it "returns a FileMetadata object" do
    fileref = double("fileref")

    expect(FilesystemTools::Validator).
      to receive(:valid?).
      and_return(true)

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

    expect(MultimediaTools::Metadata::FileMetadata).
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

    expect(FilesystemTools::Validator).
      to receive(:valid?).
      and_return(true)

    expect(fileref).
      to receive(:tag).
      and_return(false)

    expect(fileref).
      to receive(:audio_properties).
      and_return(false)

    expect(MultimediaTools::Metadata::Ffprobe).
      to receive(:new).
      with("fake.txt").
      and_return(ffprobe)

    expect(ffprobe).to receive(:tags)
    expect(ffprobe).to receive(:properties)

    expect(MultimediaTools::Metadata::FileMetadata).
      to receive(:process!)

    subject.tags("fake.txt")
  end

  it "returns an empty OpenStruct if not a valid file" do
    expect(FilesystemTools::Validator).
      to receive(:valid?).
      with("fake.txt").
      and_return(false)

    tags = MultimediaTools::Metadata::Read.new("fake.txt").tags
    expect(tags).to be_a(OpenStruct)
  end
end
