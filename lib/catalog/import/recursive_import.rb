require 'catalog/import/import_file'
require 'catalog/import/find_files'

module Catalog
  module Import
    class RecursiveImport
      attr_reader :directory

      def initialize(directory)
        @directory = directory
      end

      def scan
        files.each do |file|
          ImportFile.add(file)
        end
      end

      def self.scan(directory)
        new(directory).scan
      end

      private
      def files
        FindFiles.files(directory)
      end
    end
  end
end
