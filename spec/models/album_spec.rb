require 'spec_helper'

describe Album do
  let(:album) { Album.new }

  context "associations" do
    it { should belong_to(:artist) }
    it { should belong_to(:genre) }
    it { should belong_to(:release_date) }
    it { should have_many(:songs).dependent(:destroy) }
  end

  context "validations" do
    it { should validate_presence_of(:artist_id) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).scoped_to(:artist_id) }
  end

  context "delegated methods from Release Date" do
    it { expect(album).to respond_to(:year) }
  end

  context "delegated methods from Genre" do
    it { expect(album).to respond_to(:genre_name) }
  end

  context "#songs_by_track" do
    it "sorts songs by track" do
      album = Album.create!(title: "Low", artist_id: 1)

      song_one = Song.
        create!(title: "Warszawa", album: album, artist_id: 1, track: 8)

      song_two = Song.
        create!(title: "Sound and Vision", album: album, artist_id: 1, track: 4)

      expect(album.songs_by_track.first).to eq(song_two)
      expect(album.songs_by_track.last).to eq(song_one)
    end
  end
end
