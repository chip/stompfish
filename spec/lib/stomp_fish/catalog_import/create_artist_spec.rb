require 'stomp_fish/catalog_import/create_artist'

module StompFish
  module CatalogImport
    describe CreateArtist do
      let(:tags) { {artist: "David Bowie"} }
      let(:artist_model) { Class.new} 

      it "adds new Artist" do
        stub_const("ArtistModel", artist_model)

        expect(artist_model).to receive(:find_or_create_by).with(name: "David Bowie")
        CreateArtist.add(tags, artist_model: artist_model)
      end
    end
  end
end
