module Catalog
  module Import
    class CreateAlbum
      attr_reader :title, :artist, :date, :genre, :album_model

      def initialize(title: title, artist: artist, date: date, genre: genre, album_model: Album)
        @title, @artist, @date, @genre, @album_model = title, artist, date, genre, album_model
      end

      def add
        album = album_model.find_or_create_by(title: title, artist: artist)
        album.update(date: date, genre: genre)
        album
      end

      def self.add(title: title, artist: artist, date: date, genre: genre, album_model: Album)
        new(title: title, artist: artist, date: date, genre: genre, album_model: album_model).add
      end
    end
  end
end
