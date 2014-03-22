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
end
