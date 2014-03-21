require 'catalog/import/create_song'

module Catalog
  module Import
    describe CreateSong do
      let(:tags) { {title: "Warszawa", track: "8"} }
      let(:song_model) { Class.new} 
      let(:album) { double(artist: "foo") }

      it "adds new Song" do
        stub_const("SongModel", song_model)

        expect(song_model).
          to receive(:find_or_create_by).
          with(title: "Warszawa", artist: "foo", album: album, track: 8)

        CreateSong.add(tags, album, song_model: song_model)
      end
    end
  end
end
