module StompFish
  module CatalogImport
    class CreateArtist
      attr_reader :tags, :artist_model

      def initialize(tags, options = {})
        @tags = tags
        @artist_model = options[:artist_model] || Artist
      end

      def add
        artist_model.find_or_create_by(name: tags[:artist])
      end

      def self.add(tags, options = {})
        new(tags, options).add
      end
    end
  end
end
