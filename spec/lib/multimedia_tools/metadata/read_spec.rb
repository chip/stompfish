require 'multimedia_tools/metadata/read'

describe MultimediaTools::Metadata::Read do
  subject { MultimediaTools::Metadata::Read }

  it "has tags for a file" do
    tags = double(album: "Album", artist: "Artist",
                  year: 1975, genre: "Genre", title: "Title",
                  track: 1)

    properties = double(length: 123, bitrate: 234)
    fileref = double(tag: tags, audio_properties: properties)

    expect(FilesystemTools::Validator).
      to receive(:valid?).
      and_return(true)

    expect(TagLib::FileRef).
      to receive(:open).
      with("fake.txt").
      and_yield(fileref)

    expect(File).
      to receive(:size).
      with("fake.txt").
      and_return(456)

    tags = MultimediaTools::Metadata::Read.new("fake.txt").tags

    expect(tags).to eq({
      album: "Album",
      artist: "Artist",
      bit_rate: 234,
      date: 1975,
      duration: 123,
      filename: "fake.txt",
      filesize: 456,
      format: "txt",
      genre: "Genre",
      title: "Title",
      track: 1})
  end

  it "uses Ffprobe as a backup if TagLib fails" do
    fileref = double(tag: nil, audio_properties: nil)

    tags = double(album: "Album", artist: "Artist",
                  date: "1975", genre: "Genre", title: "Title",
                  track: "1", year: nil)

    properties = double(bitrate: nil, duration: "123",
                        bit_rate: "234", length: nil)

    ffprobe = double(tags: tags, properties: properties)

    expect(TagLib::FileRef).
      to receive(:open).
      with("fake.txt").
      and_yield(fileref)

    expect(FilesystemTools::Validator).
      to receive(:valid?).
      and_return(true)

    expect(MultimediaTools::Metadata::Ffprobe).
      to receive(:new).
      with("fake.txt").
      and_return(ffprobe)

    expect(File).
      to receive(:size).
      with("fake.txt").
      and_return(456)

    read_tags = MultimediaTools::Metadata::Read.tags("fake.txt")

    expect(read_tags).to eq({
      album: "Album",
      artist: "Artist",
      bit_rate: 234,
      date: 1975,
      duration: 123,
      filename: "fake.txt",
      filesize: 456,
      format: "txt",
      genre: "Genre",
      title: "Title",
      track: 1})
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
