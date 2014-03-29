require 'open3'

module MultimediaTools
  module Metadata
    class Ffprobe
      attr_reader :source_file

      def initialize(source_file)
        @source_file = source_file
        @run = Open3.capture3(*ffprobe_command)
      end

      def json
        return "" unless success?
        run[0]
      end

      def error
        run[1]
      end

      def success?
        run[2].success?
      end

      def self.json(source_file)
        new(source_file).json
      end

      private
      attr_reader :run

      def ffprobe_command
        %W{ffprobe -v error -print_format json -show_format} + %W{#{source_file}}
      end
    end
  end
end
