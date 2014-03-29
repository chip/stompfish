require 'json'
require 'character_encoding/replace_invalid_characters'

module MultimediaTools
  module Metadata
    class CleanRawOutput
      attr_reader :json_string

      def initialize(json_string)
        @json_string = json_string
      end

      def clean
        Hash[flat.map { |k,v| [sanitize(k), replace_invalid_characters(v)] }]
      end

      def self.clean(json_string)
        new(json_string).clean
      end

      private
      def dirty
        @dirt ||= JSON.parse(json_string)
      end

      def format
        @form ||= dirty["format"]
      end

      def flat
        tags.merge(format)
      end

      def tags
        format.delete("tags") || {}
      end

      def sanitize(k)
        k.downcase.to_sym
      end

      def replace_invalid_characters(value)
        CharacterEncoding::ReplaceInvalidCharacters.clean(value)
      end
    end
  end
end
