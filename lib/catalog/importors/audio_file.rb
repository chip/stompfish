require 'catalog/database_tools/catalog_record'
require 'audio_file_utils/validator'
require 'audio_file_utils/metadata'

module Catalog
  module Importors
    class AudioFile
      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def add
        return unless AudioFileUtils::Validator.valid?(filepath)

        begin
          Catalog::DatabaseTools::CatalogRecord.create(tags)
        rescue Exception => e
          ImportLog.create!(stacktrace: "#{e}", filename: tags[:filename])
        end
      end

      def tags
        @_tags ||= AudioFileUtils::Metadata.tags(filepath)
      end

      def self.add(filepath)
        new(filepath).add
      end
    end
  end
end
