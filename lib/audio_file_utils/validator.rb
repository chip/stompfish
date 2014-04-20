module AudioFileUtils
  class Validator
    VALID_AUDIO_FORMATS = %w(.flac .mp3 .m4a .ogg)
    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def valid?
      File.file?(filepath) and VALID_AUDIO_FORMATS.include?(extension)
    end

    def self.valid?(filepath)
      new(filepath).valid?
    end

    private
    def extension
      File.extname(filepath).downcase
    end
  end
end
