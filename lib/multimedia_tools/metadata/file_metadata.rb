require 'ostruct'

module MultimediaTools
  module Metadata
    class FileMetadata
      attr_reader :tags, :props, :filename

      def initialize(tags: tags, props: props, filename: filename)
        @tags, @props, @filename = tags, props, filename
      end

      def process!
        OpenStruct.new(artist: artist, album: album, bit_rate: bit_rate,
                       date: date, duration: duration, filename: filename,
                       filesize: filesize, format: format, genre: genre,
                       title: title, track: track)
      end

      def self.process!(tags: tags, props: props, filename: filename)
        new(tags: tags, props: props, filename: filename).process!
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

      # @props
      def bit_rate
        props.bitrate || props.bit_rate.to_i
      end

      def duration
        props.length || props.duration.to_i
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
