require 'catalog/database_tools/catalog_record'
require 'filesystem_tools/validator'
require 'multimedia_tools/metadata/read'

module Catalog
  module Importors
    class AudioFile
      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def add
        return unless FilesystemTools::Validator.valid?(filepath)

        begin
          Catalog::DatabaseTools::CatalogRecord.create(tags)
        rescue Exception => e
          ImportLog.create!(stacktrace: "#{e}", filename: tags[:filename])
        end
      end

      def tags
        @_tags ||= MultimediaTools::Metadata::Read.tags(filepath)
      end

      def self.add(filepath)
        new(filepath).add
      end
    end
  end
end
