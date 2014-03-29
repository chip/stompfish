require 'multimedia_tools/metadata/ffprobe'
require 'multimedia_tools/metadata/clean_raw_output'

module MultimediaTools
  module Metadata
    class Read
      attr_reader :source_file

      def initialize(source_file)
        @source_file = source_file
      end

      def tags
        CleanRawOutput.clean(Ffprobe.json(source_file))
      end

      def self.tags(source_file)
        new(source_file).tags
      end
    end
  end
end
