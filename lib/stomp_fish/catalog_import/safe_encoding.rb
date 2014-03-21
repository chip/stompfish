module StompFish
  module CatalogImport
    class SafeEncoding
      attr_reader :string

      def initialize(value)
        @string = value.to_s
      end

      def ensure
        return string if has_valid_encoding?
        string.encode('UTF-8', undef: :replace, invalid: :replace, replace: '')
      end

      def has_valid_encoding?
        string.valid_encoding?
      end

      def self.ensure(string)
        new(string).ensure
      end
    end
  end
end
