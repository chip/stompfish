require 'spec_helper'

describe SongSerializer do
  it "creates customized JSON for an #song" do
    artist = Artist.create(name: "David Bowie")
    album = Album.create(title: "Low", artist: artist)
    song = Song.create(title: 'Sound and Vision', track: 1, artist: artist, album: album)
    SongFile.create(filename: "filename", duration: 123, fileable_id: song.id, fileable_type: "Song", bit_rate: 345, filesize: 543, format: "flac", mtime: "today")

    serializer = SongSerializer.new(song)
    expect(serializer.to_json).to eq("{\"song\":{\"id\":#{song.id},\"title\":\"Sound and Vision\",\"bit_rate\":345,\"duration\":123.0,\"filename\":\"filename\",\"filesize\":543,\"format\":\"flac\",\"mtime\":null,\"track\":1,\"artist_id\":#{artist.id},\"album_id\":#{album.id}}}")
  end
end
