require 'spec_helper'

describe Playlist do
  context "validations" do
    it { should validate_presence_of(:title) }

    it "validates numericality of song_ids values" do
      playlist = Playlist.new(title: "foo", song_ids: %w(foo))
      playlist.save
      expect(playlist.errors.messages). to eq({song_ids: ["must be integer values"]})
    end
  end

  it "has songs" do
    artist = Artist.create(name: "Artist")
    album = Album.create(title: "Album", artist: artist)
    song = Song.create(title: "Song", artist: artist, album: album)
    playlist = Playlist.create(title: "Playlist")

    playlist.song_ids = [song.id]
    playlist.save
    expect(playlist.songs).to eq([song])
  end
end
