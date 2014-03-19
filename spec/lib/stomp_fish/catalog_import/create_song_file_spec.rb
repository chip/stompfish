require 'stomp_fish/catalog_import/create_song_file'

module StompFish
  module CatalogImport
    describe CreateSongFile do
      let(:tags) do 
        {filename: "filename", bit_rate: "bitrate",
         duration: "duration", format: "format",
         filesize: "filesize"}
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
          with(filesize: "filesize",
               bit_rate: "bitrate",
               format: "format",
               duration: "duration",
               fileable_id: 1,
               fileable_type: "Song")

          CreateSongFile.add(tags, 1, song_file_model: song_file_model)
      end
    end
  end
end
