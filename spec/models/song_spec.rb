require 'spec_helper'

describe Song do
  let(:song) { Song.new }

  it { should belong_to(:album) }
  it { should belong_to(:artist) }
  it { should have_one(:song_file) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:artist_id) }
  it { should validate_presence_of(:album_id) }
  it { should validate_uniqueness_of(:title).scoped_to([:album_id, :track])}

  context "delegated methods from SongFile" do
    it { expect(song).to respond_to(:bit_rate) }
    it { expect(song).to respond_to(:duration) }
    it { expect(song).to respond_to(:filename) }
    it { expect(song).to respond_to(:filesize) }
    it { expect(song).to respond_to(:format) }
    it { expect(song).to respond_to(:mtime) }

    it { expect(song).to respond_to(:duration_to_human) }
    it { expect(song).to respond_to(:filesize_to_human) }
  end

  context "delegated methods from Artist" do
    it { expect(song).to respond_to(:artist_name) }
  end

  context "delegated methods from Album" do
    it { expect(song).to respond_to(:album_image) }
    it { expect(song).to respond_to(:album_title) }
    it { expect(song).to respond_to(:date) }
    it { expect(song).to respond_to(:genre) }
  end

  context "scopes" do
    let!(:song) { Song.create!(title: "Foo", artist_id: 1, album_id: 1) }
    let!(:song_file) { SongFile.create!(fileable_id: song.id, filename: "Foo",
                                        fileable_type: "Song", duration: 123) }

    context "#duration_less_than" do
      it "returns all songs with duration less than x" do
        songs = Song.duration_less_than("2:04")
        expect(songs).to eq([song])
      end
    end

    context "#duration_greater_than" do
      it "returns all songs with duration greater than x" do
        songs = Song.duration_greater_than("2:02")
        expect(songs).to eq([song])
      end
    end

    context "#duration_between" do
      it "returns all songs with duration between x & y" do
        songs = Song.duration_between("2:02", "2:04")
        expect(songs).to eq([song])
      end
    end
  end
end
