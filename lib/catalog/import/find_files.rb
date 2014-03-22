require 'find'

module Catalog
  module Import
    class FindFiles
      VALID_AUDIO_FILES = %w(.flac .mp3 .m4a .ogg)
      def initialize(directory)
        @directory = directory
      end

      def directory
        File.directory?(@directory) or raise InvalidDirectory
        @directory
      end

      def files
        Find.find(directory).select { |f| is_audio_file?(f) }
      end

      def self.files(directory)
        new(directory).files
      end

      private
      def is_audio_file?(file)
        VALID_AUDIO_FILES.include?(File.extname(file).downcase)
      end
    end

    InvalidDirectory = Class.new(StandardError)
  end
end
