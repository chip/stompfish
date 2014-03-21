require 'stomp_fish/catalog_import/create_song_file'

module StompFish
  module CatalogImport
    describe CreateSongFile do
      let(:tags) do 
        {filename: "filename", bit_rate: "12345",
         duration: "123.456", format_name: "format",
         size: "12345"}
      end

      let(:song_file_model) { Class.new }
      let(:song_instance) { double(:update) }

      it "adds a SongFile" do
        stub_const("SongFileModel", song_file_model)

        expect(song_file_model).
          to receive(:find_or_create_by).
          with(filename: "filename").
          and_return(song_instance)

        expect(song_instance).
          to receive(:update).
          with(filesize: 12345,
               bit_rate: 12345,
               format: "format",
               duration: 123.456,
               fileable_id: 1,
               fileable_type: "Song")

          CreateSongFile.add(tags, 1, song_file_model: song_file_model)
      end
    end
  end
end
