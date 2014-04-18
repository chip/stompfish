require 'ostruct'

module MultimediaTools
  module Metadata
    class FileMetadata
      attr_reader :tags, :properties, :filename

      def initialize(tags: tags, properties: properties, filename: filename)
        @tags, @properties, @filename = tags, properties, filename
      end

      def process!
        OpenStruct.new(artist: artist, album: album, bit_rate: bit_rate,
                       date: date, duration: duration, filename: filename,
                       filesize: filesize, format: format, genre: genre,
                       title: title, track: track)
      end

      private
      # @tags
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

      # @properties
      def bit_rate
        properties.bitrate || properties.bit_rate.to_i
      end

      def duration
        properties.length || properties.duration.to_i
      end

      # @source_file
      def filesize
        File.size(filename)
      end

      def format
        File.extname(filename)[1..-1]
      end
    end
  end
end
