require 'spec_helper'

describe PlaylistSerializer do
  it "creates customized JSON for an #playlist" do
    playlist = Playlist.create(title: "Sample Playlist")
    artist = Artist.create(name: "Artist")
    album = Album.create(title: "Album", artist: artist)
    song = Song.create(title: "Song", artist: artist, album: album)

    PlaylistCollaborator.create(song: song, playlist: playlist, position: 1)

    serializer = PlaylistSerializer.new(playlist)
    expect(serializer.to_json).
      to eq("{\"playlist\":{\"id\":#{playlist.id},\"title\":\"Sample Playlist\",\"songs\":[{\"id\":#{song.id},\"position\":1}]}}")
  end
end
