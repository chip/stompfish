require 'ostruct'
require 'taglib'
require 'filesystem_tools/validator'
require 'multimedia_tools/metadata/ffprobe'
require 'multimedia_tools/metadata/file_metadata'

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
          tags = fileref.tag || ffprobe.tags
          properties = fileref.audio_properties || ffprobe.properties

          FileMetadata.new(filename: source_file, tags: tags, properties: properties).process!
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
