require 'catalog/import/ffprobe'
require 'catalog/import/song_tag'

module Catalog
  module Import
    class ReadFile
      attr_reader :source_file

      def initialize(source_file)
        @source_file = source_file
      end

      def tags
        SongTag.clean(Ffprobe.json(source_file))
      end

      def self.tags(source_file)
        new(source_file).tags
      end
    end
  end
end
