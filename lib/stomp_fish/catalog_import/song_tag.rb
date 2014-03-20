require 'json'

module StompFish
  module CatalogImport
    class SongTag
      attr_reader :json_string

      def initialize(json_string)
        @json_string = json_string
      end

      def clean
        Hash[flat.map { |k,v| [sanitize(k), fix_bad_encoding(v.to_s)] }]
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

      def fix_bad_encoding(str)
        return str if str.valid_encoding?
        str.encode('UTF-8', undef: :replace, invalid: :replace, replace: '')
      end
    end
  end
end
