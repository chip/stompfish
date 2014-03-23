require 'spec_helper'

describe Artist do
  context "associations" do
    it { should have_many(:albums) }
    it { should have_many(:songs) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  context "#albums_by_date" do
    it "sorts albums by date" do
      artist = Artist.create(name: "David Bowie")
      year_one = ReleaseDate.create(year: 1973)
      year_two = ReleaseDate.create(year: 1977)

      album_one = Album.
        create(title: "Low", release_date_id: year_two.id, artist: artist)

      album_two = Album.
        create(title: "Aladdin Sane", release_date_id: year_one.id, artist: artist)

      expect(artist.albums_by_date.first).to eq(album_two)
      expect(artist.albums_by_date.last).to eq(album_one)
    end
  end
end
