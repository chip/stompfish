module AudioFileUtils
  module MetadataCore
    TagAttributesStruct = Struct.new(:album, :artist, :date, :genre, :title, :track)

    class TagAttributes
      attr_reader :tags

      def initialize(tags)
        @tags = tags
      end

      def info
        TagAttributesStruct.new(album, artist, date, genre, title, track)
      end

      private
      def album
        tags.album
      end

      def artist
        tags.artist
      end

      def date
        tags.year || tags.date.to_i
      end

      def genre
        tags.genre
      end

      def title
        tags.title
      end

      def track
        tags.track.to_i
      end
    end
  end
end
