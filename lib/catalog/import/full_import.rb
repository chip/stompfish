require 'catalog/import/import_file'
require 'catalog/import/find_files'
require 'catalog/import/safe_encoding'

module Catalog
  module Import
    class FullImport
      attr_reader :directory

      def initialize(directory)
        @directory = directory
      end

      def scan
        files.each do |file|
          begin
            ImportFile.add(file)
          rescue Exception => e
            fixed = SafeEncoding.ensure(file)
            ImportLog.create!(stacktrace: "#{e}", filename: fixed)
          end
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
