require 'services/lastfm/download'

describe Services::Lastfm::Download do
  subject { described_class }

  let(:url) { "http://example.com/image.png" }

  it "downloads a source url to a destination" do
    file = double("new_file")
    opened = double("open_uri")
    read = double("read_uri")

    downloader = subject.new(url: url, destination: "/my/tmpdir")

    expect(File).
      to receive(:open).
      with("/my/tmpdir/image.png", "w:ASCII-8BIT").
      and_yield(file)

    expect(downloader).
      to receive(:open).
      with(url).
      and_return(opened)

    expect(opened).
      to receive(:read).
      and_return(read)

    expect(file).
      to receive(:write).
      with(read)

    downloader.save
  end

  it "returns the location of the downloaded file" do
    downloader = subject.new(url: url, destination: "/my/tmpdir")

    expect(downloader.location).
      to eq("/my/tmpdir/image.png")
  end
end
