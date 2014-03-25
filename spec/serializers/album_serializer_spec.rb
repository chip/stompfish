require 'spec_helper'

describe AlbumSerializer do
  it "creates customized JSON for an #album" do
    artist = Artist.create!(name: "David Bowie")
    album = Album.create!(title: "Low", artist: artist)

    serializer = AlbumSerializer.new(album)
    expect(serializer.to_json).
      to eq("{\"album\":{\"id\":#{album.id},\"title\":\"Low\"}}")
  end
end
