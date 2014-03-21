require 'find'
require 'catalog/import/import_file'

module Catalog
  module Import
    InvalidDirectory = Class.new(StandardError)

    class ImportDirectory
      AUDIO_FILE_EXTENSIONS = %w(.flac .mp3 .m4a .ogg)
      attr_reader :directory

      def initialize(directory)
        @directory = directory
        File.directory?(@directory) or raise InvalidDirectory
      end

      def scan!
        files.each do |file|
          ImportFile.add(file)
        end
      end

      def scan
        files.each do |file|
          begin
            ImportFile.add(file)
          rescue Exception => e
            ImportLog.create!(stacktrace: "#{e}", filename: file)
          end
        end
      end

      def self.scan(directory)
        new(directory).scan
      end

      def files
        Find.find(directory).select { |f| f if audio_file?(f) }
      end

      private
      def audio_file?(file)
        AUDIO_FILE_EXTENSIONS.include?(File.extname(file).downcase)
      end
    end
  end
end
