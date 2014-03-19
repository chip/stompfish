module StompFish
  module CatalogImport
    class CreateSongFile
      attr_reader :tags, :song_id, :song_file_model

      def initialize(tags, song_id, options = {})
        @tags = tags
        @song_id = song_id
        @song_file_model = options[:song_file_model] || SongFile
      end

      def add
        file = song_file_model.find_or_create_by(filename: tags[:filename])
        file.update(bit_rate: tags[:bit_rate],
                  duration: tags[:duration],
                  filesize: tags[:size],
                  format: tags[:format_name],
                  fileable_id: song_id,
                  fileable_type: "Song")
        file
      end

      def self.add(tags, song_id, options = {})
        new(tags, song_id, options).add
      end
    end
  end
end
