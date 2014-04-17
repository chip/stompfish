module Catalog
  module DatabaseTools
    class CatalogRecord
      attr_reader :tags

      def initialize(tags)
        @tags = tags
      end

      def create
        updateable = Song.find(song.id)
        updateable.song_file = song_file
        updateable.save
      end

      def self.create(tags)
        new(tags).create
      end
      
      private
      def artist
        Catalog::DatabaseTools::ArtistRecord.add(name: tags[:artist])
      end

      def genre
        Catalog::DatabaseTools::GenreRecord.add(name: tags[:genre])
      end

      def release_date
        Catalog::DatabaseTools::ReleaseDateRecord.add(year: tags[:date])
      end

      def album
        Catalog::DatabaseTools::AlbumRecord.add(title: tags[:album], artist: artist,
                        genre: genre, release_date: release_date)
      end

      def song_file
        Catalog::DatabaseTools::SongFileRecord.add(tags, fileable_id: song.id)
      end

      def song
        @created_song ||= Catalog::DatabaseTools::SongRecord.add(tags, album)
      end
    end
  end
end
