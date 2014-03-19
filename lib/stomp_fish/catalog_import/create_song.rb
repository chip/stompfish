module StompFish
  module CatalogImport
    class CreateSong
      attr_reader :tags, :artist_id, :album_id, :song_model

      def initialize(tags, artist_id, album_id, options = {})
        @tags = tags
        @artist_id = artist_id
        @album_id = album_id
        @song_model = options[:song_model] || Song
      end

      def add
        song = song_model.find_or_create_by(title: tags[:title],
                                            artist_id: artist_id,
                                            album_id: album_id)
        song.update(track: tags[:track].to_i)
      end

      def self.add(tags, artist_id, album_id, options = {})
        new(tags, artist_id, album_id, options).add
      end
    end
  end
end
