module Catalog
  module DatabaseTools
    class SongRecord
      attr_reader :tags, :album, :song_model

      def initialize(tags, album, options = {})
        @tags = tags
        @album = album
        @song_model = options[:song_model] || Song
      end

      def add
        song = song_model.find_or_create_by(title: tags[:title],
                                            artist: album.artist,
                                            album: album,
                                            track: tags[:track].to_i)
        song
      end

      def self.add(tags, album, options = {})
        new(tags, album, options).add
      end
    end
  end
end
