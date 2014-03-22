require 'spec_helper'

describe Playlist do
  context "relationships" do
    it { should have_and_belong_to_many(:songs) }
  end

  context "validations" do
    it { should validate_presence_of(:title) }
  end

  context "#runtime" do
    it "calculates total runtime of playlist" do
      song_one = Song.create(title: "One", artist_id: 1, album_id: 2)
      song_two = Song.create(title: "Two", artist_id: 1, album_id: 2)

      song_file_one = SongFile.create(filename: "One", fileable_id: song_one.id,
                                      fileable_type: "Song", duration: 123)

      song_file_two = SongFile.create(filename: "Two", fileable_id: song_two.id,
                                      fileable_type: "Song", duration: 345)

      playlist = Playlist.new(title: "Playlist")
      playlist.songs = [song_one, song_two]
      playlist.save

      expect(playlist.runtime).to eq("07:48")
    end
  end
end
