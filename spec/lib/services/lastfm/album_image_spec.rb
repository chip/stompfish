require 'services/lastfm/album_image'
require 'spec_helper'

describe Services::Lastfm::AlbumImage do
  subject { described_class }

  it "downloads an album image from Lastfm for @artist & @album" do
    converted = double("Services::Lastfm::Convert instance")
    download = double("Services::Lastfm::Download instance")
    uri = double("Lastfm::Uri")

    response = {"album"=>{"image"=>["#text"=>"one.jpg"]}}

    tags = double(artist: "David Bowie", album: "Aladdin Sane", filename: "tmp/David Bowie/Aladdin Sane/test.mp3")
    audio_file = double(tags: tags)

    expect(Services::Lastfm::Uri).
      to receive(:new).
      with("album.getinfo&artist=David+Bowie&album=Aladdin+Sane").
      and_return(uri)

    expect(uri).
      to receive(:get).
      and_return(response)

    expect(Services::Lastfm::Download).
      to receive(:new).
      with(tags: tags, url: "one.jpg").
      and_return(download)

    expect(download).
      to receive(:save).
      and_return(true)

    expect(download).
      to receive(:location).
      and_return("tmp/David Bowie/Aladdin Sane/one.jpg")

    expect(Services::Lastfm::Convert).
      to receive(:new).
      with("tmp/David Bowie/Aladdin Sane/one.jpg").
      and_return(converted)

    expect(converted).to receive(:convert)

    expect(converted).
      to receive(:new_path).
      and_return("tmp/David Bowie/Aladdin Sane/folder.jpg")

    downloaded = subject.new(audio_file).download

    expect(downloaded).to eq("tmp/David Bowie/Aladdin Sane/folder.jpg")
  end
end
