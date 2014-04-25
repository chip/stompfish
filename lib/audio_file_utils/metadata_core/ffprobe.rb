require 'open3'
require 'json'
require 'active_support'
require 'audio_file_utils/metadata_core/sanitize_ffprobe_output'

module AudioFileUtils
  module MetadataCore
    class Ffprobe
      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def tags
        SanitizeFfprobeOutput.clean(unformatted_tags)
      end

      def properties
        SanitizeFfprobeOutput.clean(format)
      end

      private
      def scan
        Open3.capture3(*command)[0]
      end

      def json
        @json_object ||= JSON.parse(scan)
      end

      def unformatted_tags
        json["format"].delete("tags")
      end

      def format
        json["format"].except("tags")
      end

      def command
        %W{ffprobe -show_format -print_format json} + %W{#{filepath}}
      end
    end
  end
end
