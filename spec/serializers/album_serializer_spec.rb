require 'spec_helper'

describe AlbumSerializer do
  it "creates customized JSON for an #album" do
    album = Album.new(title: "Low")

    serializer = AlbumSerializer.new(album)
    expect(serializer.to_json).
      to eq('{"album":{"id":null,"title":"Low","artist_id":null,"genre":null,"release_date":null,"song_ids":[]}}')
  end
end
