require 'taglib'
require 'audio_file_utils/metadata_core/audio_properties'
require 'audio_file_utils/metadata_core/ffprobe'
require 'audio_file_utils/metadata_core/tag_attributes'

module AudioFileUtils
  module MetadataCore
    class ReadTool
      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def read
        TagLib::FileRef.open(filepath) do |ref|
          @props = ref.audio_properties || ffprobe.properties
          @tags = ref.tag || ffprobe.tags
          [*audio_properties, *tag_attributes]
        end
      end

      private
      def audio_properties
        AudioProperties.new(@props).info
      end

      def ffprobe
        @_ffprobe ||= Ffprobe.new(filepath)
      end

      def tag_attributes
        TagAttributes.new(@tags).info
      end
    end
  end
end
