require 'stomp_fish/catalog_import/create_song'

module StompFish
  module CatalogImport
    describe CreateSong do
      let(:tags) { {title: "Warszawa", track: "8"} }
      let(:song_model) { Class.new} 
      let(:song_instance) { double(:update) }
      let(:album) { double(id: 1, artist_id: 1) }

      it "adds new Song" do
        stub_const("SongModel", song_model)

        expect(song_model).
          to receive(:find_or_create_by).
          with(title: "Warszawa", artist_id: 1, album_id: 1).
          and_return song_instance

        expect(song_instance).
          to receive(:update).
          with(track: 8)

        CreateSong.add(tags, album, song_model: song_model)
      end
    end
  end
end
