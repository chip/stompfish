module StompFish
  module CatalogImport
    class CreateSong
      attr_reader :tags, :album, :song_model

      def initialize(tags, album, options = {})
        @tags = tags
        @album = album
        @song_model = options[:song_model] || Song
      end

      def add
        song = song_model.find_or_create_by(title: tags[:title],
                                            artist_id: album.artist_id,
                                            album_id: album.id)
        song.update(track: tags[:track].to_i)
      end

      def self.add(tags, album, options = {})
        new(tags, album, options).add
      end
    end
  end
end
