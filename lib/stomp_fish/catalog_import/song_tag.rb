require 'json'
require 'stomp_fish/catalog_import/safe_encoding'

module StompFish
  module CatalogImport
    class SongTag
      attr_reader :json_string

      def initialize(json_string)
        @json_string = json_string
      end

      def clean
        Hash[flat.map { |k,v| [sanitize(k), ensure_valid_encoding(v)] }]
      end

      def self.clean(json_string)
        new(json_string).clean
      end

      private
      def dirty
        @dirt ||= JSON.parse(json_string)
      end

      def format
        dirty["format"]
      end

      def tags
        format["tags"]
      end

      def flat
        format.delete("tags").merge(format)
      end

      def sanitize(k)
        k.downcase.to_sym
      end

      def ensure_valid_encoding(value)
        SafeEncoding.ensure(value)
      end
    end
  end
end
