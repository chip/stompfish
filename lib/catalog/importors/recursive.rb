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
        files.each do |file|
          SingleFile.add(file)
          block.call if block_given?
        end
      end

      def self.scan(directory)
        new(directory).scan
      end

      private
      def files
        FilesystemTools::FindFiles.files(directory)
      end
    end
  end
end
