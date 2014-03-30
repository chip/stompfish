require 'catalog/importors/single_file'
require 'filesystem_tools/find_files'

module Catalog
  module Importors
    class Recursive
      attr_reader :directory

      def initialize(directory)
        @directory = directory
      end

      def scan(&block)
        files(&block).each do |file|
          unless SongFile.find_by(filename: file)
            SingleFile.add(filepath: file)
            yield if block_given?
          end
        end
      end

      def self.scan(directory, &block)
        new(directory).scan(&block)
      end

      private
      def files
        FilesystemTools::FindFiles.files(directory)
      end
    end
  end
end
