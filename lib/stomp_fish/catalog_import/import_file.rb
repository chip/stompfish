require 'stomp_fish/catalog_import/read_file'
require 'stomp_fish/catalog_import/create_artist'
require 'stomp_fish/catalog_import/create_album'
require 'stomp_fish/catalog_import/create_song'
require 'stomp_fish/catalog_import/create_song_file'

module StompFish
  module CatalogImport
    class ImportFile
      attr_reader :tags

      def initialize(filepath)
        @tags = ReadFile.tags(filepath)
      end

      def add
        updateable = Song.find(song.id)
        updateable.song_files = [song_file]
        updateable.save
      end

      def self.add(filepath)
        new(filepath).add
      end

      private
      def artist
        CreateArtist.add(tags)
      end

      def album
        CreateAlbum.add(tags, artist)
      end

      def song_file
        CreateSongFile.add(tags, fileable_id: song.id)
      end

      def song
        @created_song ||= CreateSong.add(tags, album)
      end
    end
  end
end
