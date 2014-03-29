require 'multimedia_tools/metadata/read'
require 'filesystem_tools/find_files'
require 'parallel'

module MultimediaTools
  module Metadata
    class TagStore
      attr_reader :directory

      def initialize(directory)
        @directory = directory
      end

      def store
        Parallel.map(files, in_processes: 8) do |file|
          MultimediaTools::Metadata::Read.tags(file)
        end
      end

      def self.store(directory)
        new(directory).store
      end

      private

      def files
        FilesystemTools::FindFiles.files(directory)
      end
    end
  end
end
