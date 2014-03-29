module CharacterEncoding
  class ReplaceInvalidCharacters
    attr_reader :string

    def initialize(value)
      @string = value.to_s
    end

    def clean
      return string if has_valid_encoding?
      string.encode('UTF-8', undef: :replace, invalid: :replace, replace: '')
    end

    def has_valid_encoding?
      string.valid_encoding?
    end

    def self.clean(string)
      new(string).clean
    end
  end
end
