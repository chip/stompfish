require 'json'

module StompFish
  module CatalogImport
    class SongTag
      attr_reader :json_string

      def initialize(json_string)
        @json_string = json_string
      end

      def clean
        Hash[flat.map { |k,v| [sanitize(k), replace_invalid_byte_sequence(v)] }]
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

      def replace_invalid_byte_sequence(value)
        value.
          to_s.
          encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
      end
    end
  end
end
