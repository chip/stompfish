require 'spec_helper'

describe PlaylistSerializer do
  it "creates customized JSON for an #playlist" do
    artist = Artist.create(name: "Artist")
    album = Album.create(title: "Album", artist: artist)
    song = Song.create(title: "Song", artist: artist, album: album)
    playlist = Playlist.create(title: "Sample Playlist", song_ids: [song.id])

    serializer = PlaylistSerializer.new(playlist)
    expect(serializer.to_json).
      to eq("{\"playlist\":{\"id\":#{playlist.id},\"title\":\"Sample Playlist\",\"song_ids\":[#{song.id}]}}")
  end
end
