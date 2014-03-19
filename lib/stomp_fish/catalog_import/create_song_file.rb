module StompFish
  module CatalogImport
    class CreateSongFile
      attr_reader :tags, :song_id, :song_file_model

      def initialize(tags, song_id, options = {})
        @tags = tags
        @song_id = song_id
        @song_file_model = options[:song_file_model] || SongFileModel
      end

      def add
        sf = song_file_model.find_or_create_by(filename: tags[:filename])
        sf.update(bit_rate: tags[:bit_rate],
                  duration: tags[:duration],
                  filesize: tags[:filesize],
                  format: tags[:format],
                  fileable_id: song_id,
                  fileable_type: "Song")
      end

      def self.add(tags, song_id, options = {})
        new(tags, song_id, options).add
      end
    end
  end
end
