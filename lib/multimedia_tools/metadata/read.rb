require 'taglib'

module MultimediaTools
  module Metadata
    class Read
      attr_reader :source_file

      def initialize(source_file)
        @source_file = source_file
      end

      def tags
        TagLib::FileRef.open(source_file) do |fileref|
          tag = fileref.tag
          properties = fileref.audio_properties

          new_file = {
            album: tag.album,
            artist: tag.artist,
            bit_rate: properties.bitrate,
            date: tag.year,
            duration: properties.length,
            filename: source_file,
            filesize: File.size(source_file),
            format: File.extname(source_file)[1..-1],
            genre: tag.genre,
            title: tag.title,
            track: tag.track
          }
        end
      end

      def self.tags(source_file)
        new(source_file).tags
      end
    end
  end
end
