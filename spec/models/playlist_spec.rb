require 'spec_helper'

describe Playlist do
  context "associations" do
    it { should have_many(:songs).through(:playlist_collaborators) }
  end

  context "validations" do
    it { should validate_presence_of(:title) }
  end

  context "#play_order" do
    it "sorts songs by position in the playlist" do
      playlist = Playlist.new

      expect(playlist.songs).
        to receive(:order).
        with("position ASC")

      playlist.play_order
    end
  end

  context "#runtime" do
    it "calculates total runtime of playlist" do
      song_one = Song.create!(title: "One", artist_id: 1, album_id: 2)
      song_two = Song.create!(title: "Two", artist_id: 1, album_id: 2)

      song_file_one = SongFile.create!(filename: "One", fileable_id: song_one.id,
                                       fileable_type: "Song", duration: 123)

      song_file_two = SongFile.create!(filename: "Two", fileable_id: song_two.id,
                                       fileable_type: "Song", duration: 345)

      playlist = Playlist.create(title: "Playlist")
      PlaylistCollaborator.create(position: 1, playlist_id: playlist.id, song_id: song_one.id)
      PlaylistCollaborator.create(position: 2, playlist_id: playlist.id, song_id: song_two.id)

      expect(playlist.runtime).to eq("07:48")
    end
  end
end
