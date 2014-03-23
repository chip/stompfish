require 'catalog/import/read_file'
require 'catalog/import/create_artist'
require 'catalog/import/create_album'
require 'catalog/import/create_song'
require 'catalog/import/create_song_file'

module Catalog
  module Import
    class ImportFile
      def initialize(filepath)
        @filepath = filepath
      end

      def filepath
        File.exists?(@filepath) or raise FileNotFound
        @filepath
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
        CreateArtist.add(name: tags[:artist])
      end

      def genre
        CreateGenre.add(name: tags[:genre])
      end

      def album
        CreateAlbum.add(title: tags[:album], artist: artist,
                        genre: genre, date: tags[:date].to_i)
      end

      def song_file
        CreateSongFile.add(tags, fileable_id: song.id)
      end

      def song
        @created_song ||= CreateSong.add(tags, album)
      end
    end

    FileNotFound = Class.new(StandardError)
  end
end
