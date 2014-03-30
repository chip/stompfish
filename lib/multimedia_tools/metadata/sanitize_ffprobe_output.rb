require 'character_encoding/replace_invalid_characters'
require 'ostruct'

module MultimediaTools
  module Metadata
    class SanitizeFfprobeOutput
      attr_reader :dirty

      def initialize(dirty)
        @dirty = dirty
      end

      def clean
        OpenStruct.new(Hash[dirty.map { |k,v| [downcase_to_symbol(k), clean_encode(v)] } ])
      end
      
      def self.clean(dirty)
        new(dirty).clean
      end

      private
      def clean_encode(string)
        CharacterEncoding::ReplaceInvalidCharacters.clean(string)
      end

      def downcase_to_symbol(k)
        k.downcase.to_sym
      end
    end
  end
end
