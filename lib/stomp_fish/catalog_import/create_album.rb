module StompFish
  module CatalogImport
    class CreateAlbum
      attr_reader :tags, :artist_id, :album_model

      def initialize(tags, artist_id, options = {})
        @tags = tags
        @artist_id = artist_id
        @album_model = options[:album_model] || Album
      end

      def add
        album = album_model.find_or_create_by(title: "Low", artist_id: artist_id)
        album.update(date: tags[:date].to_i, genre: tags[:genre])
      end

      def self.add(tags, artist_id, options = {})
        new(tags, artist_id, options).add
      end
    end
  end
end
