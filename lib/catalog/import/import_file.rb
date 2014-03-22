require 'catalog/import/read_file'
require 'catalog/import/create_artist'
require 'catalog/import/create_album'
require 'catalog/import/create_song'
require 'catalog/import/create_song_file'

module Catalog
  module Import
    class ImportFile
      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def add
        updateable = Song.find(song.id)
        updateable.song_file = song_file
        updateable.save
      end

      def tags
        @read_tags ||= ReadFile.tags(filepath)
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
