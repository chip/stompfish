require 'stomp_fish/catalog_import/create_album'

module StompFish
  module CatalogImport
    describe CreateAlbum do
      let(:tags) { {album: "Low", date: "1997", genre: "Pop/Rock"} }
      let(:album_model) { Class.new} 
      let(:album_instance) { double(:update) }

      it "adds new Album" do
        stub_const("AlbumModel", album_model)

        expect(album_model).
          to receive(:find_or_create_by).
          with(title: "Low", artist: 1).
          and_return album_instance

        expect(album_instance).
          to receive(:update).
          with(date: 1997, genre: "Pop/Rock")

        CreateAlbum.add(tags, 1, album_model: album_model)
      end
    end
  end
end
