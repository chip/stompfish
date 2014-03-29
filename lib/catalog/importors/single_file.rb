module Catalog
  module Importors
    class SingleFile
      def initialize(filepath)
        @filepath = filepath
      end

      def filepath
        File.exists?(@filepath) or raise FileNotFound
        @filepath
      end

      def add
        begin
          updateable = Song.find(song.id)
          updateable.song_file = song_file
          updateable.save
        rescue Exception => e
          fixed = CharacterEncoding::ReplaceInvalidCharacters.clean(filepath)
          ImportLog.create!(stacktrace: "#{e}", filename: fixed)
        end
      end

      def tags
        @read_tags ||= MultimediaTools::Metadata::Read.tags(filepath)
      end

      def self.add(filepath)
        new(filepath).add
      end

      private
      def artist
        Catalog::DatabaseTools::ArtistRecord.add(name: tags[:artist])
      end

      def genre
        Catalog::DatabaseTools::GenreRecord.add(name: tags[:genre])
      end

      def release_date
        Catalog::DatabaseTools::ReleaseDateRecord.add(year: tags[:date].to_i)
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

    FileNotFound = Class.new(StandardError)
  end
end
