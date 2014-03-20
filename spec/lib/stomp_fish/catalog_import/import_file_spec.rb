require 'stomp_fish/catalog_import/import_file'

module StompFish
  module CatalogImport
    describe ImportFile do
      let(:filepath) { double("filepath") }
      let(:read_file) { Class.new }

      let(:create_artist) { Class.new }
      let(:artist_instance) { double(id: 1) }

      let(:create_album) { Class.new }
      let(:album_instance) { double("album") }

      let(:create_song) { Class.new }
      let(:song_instance) { double(id: 2) }

      let(:create_song_file) { Class.new }
      let(:song_file_instance) { double("song_file_instance") }

      let(:song) { Class.new }
      let(:updateable) { double("updateable") }

      let(:tags) { double("tags") }

      it "adds a new entry to the catalog" do
        stub_const("ReadFile", read_file)
        stub_const("CreateArtist", create_artist)
        stub_const("CreateAlbum", create_album)
        stub_const("CreateSong", create_song)
        stub_const("CreateSongFile", create_song_file)
        stub_const("Song", song)

        expect(ReadFile).
          to receive(:tags).
          with(filepath).
          and_return(tags)

        expect(CreateArtist).
          to receive(:add).
          with(tags).
          and_return(artist_instance)

        expect(CreateAlbum).
          to receive(:add).
          with(tags, artist_instance).
          and_return(album_instance)

        expect(CreateSong).
          to receive(:add).
          with(tags, album_instance).
          and_return(song_instance)

        expect(CreateSongFile).
          to receive(:add).
          with(tags, fileable_id: 2).
          and_return(song_file_instance)

        expect(Song).
          to receive(:find).
          with(2).
          and_return(updateable)

        expect(updateable).
          to receive(:song_file=).
          with(song_file_instance).
          and_return(updateable)

        expect(updateable).to receive(:save)

        ImportFile.new(filepath).add
      end
    end
  end
end
