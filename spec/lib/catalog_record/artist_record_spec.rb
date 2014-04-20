require 'catalog_record/artist_record'

describe CatalogRecord::ArtistRecord do
  subject { CatalogRecord::ArtistRecord }

  let(:name) { "David Bowie" }
  let(:artist_model) { Class.new} 

  before { stub_const("Artist", artist_model) }

  context ".add" do
    it "adds new Artist" do
      expect(artist_model).
        to receive(:find_or_create_by).
        with(name: "David Bowie")

      subject.add(name: "David Bowie", artist_model: artist_model)
    end
  end

  context "#artist_model" do
    it "defaults artist model to Artist" do
      creator = subject.new(name: "David Bowie")
      expect(creator.artist_model).to eq(Artist)
    end
  end
end
