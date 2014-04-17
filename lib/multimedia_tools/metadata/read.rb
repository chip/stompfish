require 'ostruct'
require 'taglib'
require 'filesystem_tools/validator'
require 'multimedia_tools/metadata/ffprobe'

module MultimediaTools
  module Metadata
    class Read
      attr_reader :source_file

      def initialize(source_file)
        @source_file = source_file
      end

      def tags
        return OpenStruct.new unless FilesystemTools::Validator.valid?(source_file)

        TagLib::FileRef.open(source_file) do |fileref|
          tag = fileref.tag || ffprobe.tags
          properties = fileref.audio_properties || ffprobe.properties

          new_file = {
            album: tag.album,
            artist: tag.artist,
            bit_rate: properties.bitrate || properties.bit_rate.to_i,
            date: tag.year || tag.date.to_i,
            duration: properties.length || properties.duration.to_i,
            filename: source_file,
            filesize: File.size(source_file),
            format: File.extname(source_file)[1..-1],
            genre: tag.genre,
            title: tag.title,
            track: tag.track.to_i
          }
        end
      end

      def self.tags(source_file)
        new(source_file).tags
      end

      private
      def ffprobe
        # TagLib has problems with some tags, but is about 6 times faster than Ffprobe
        # Ffprobe serves as a suitable backup when TagLib fails to read tags
        @probe ||= Ffprobe.new(source_file)
      end
    end
  end
end
