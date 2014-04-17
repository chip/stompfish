require 'catalog/importors/audio_file'
require 'find'

module Catalog
  module Importors
    class Recursive
      attr_reader :directory

      def initialize(directory)
        @directory = directory
      end

      def scan
        files.each do |file|
          AudioFile.add(file)
        end
      end

      def self.scan(directory)
        new(directory).scan
      end

      private
      def files
        Find.find(directory)
      end
    end
  end
end
