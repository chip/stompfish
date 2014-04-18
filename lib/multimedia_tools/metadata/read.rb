require 'taglib'
require 'filesystem_tools/validator'
require 'multimedia_tools/metadata/ffprobe'
require 'multimedia_tools/metadata/file_metadata'

module MultimediaTools
  module Metadata
    class Read
      attr_reader :file

      def initialize(file)
        @file = file
      end

      def tags
        return OpenStruct.new unless FilesystemTools::Validator.valid?(file)

        TagLib::FileRef.open(file) do |fileref|
          tags = fileref.tag || ffprobe.tags
          props = fileref.audio_properties || ffprobe.properties

          FileMetadata.process!(filename: file, tags: tags, props: props)
        end
      end

      def self.tags(file)
        new(file).tags
      end

      private
      def ffprobe
        # TagLib has problems with some tags, but is about 6 times faster than Ffprobe
        # Ffprobe serves as a suitable backup when TagLib fails to read tags
        @_ffprobe ||= Ffprobe.new(file)
      end
    end
  end
end
