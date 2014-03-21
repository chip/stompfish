module Catalog
  module Import
    class CreateAlbum
      attr_reader :tags, :artist, :album_model

      def initialize(tags, artist, options = {})
        @tags = tags
        @artist = artist
        @album_model = options[:album_model] || Album
      end

      def add
        album = album_model.find_or_create_by(title: tags[:album], artist: artist)
        album.update(date: tags[:date].to_i, genre: tags[:genre])
        album
      end

      def self.add(tags, artist, options = {})
        new(tags, artist, options).add
      end
    end
  end
end
