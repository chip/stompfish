require 'taglib'
require 'audio_file_utils/validator'
require 'audio_file_utils/metadata_core/ffprobe'
require 'audio_file_utils/metadata_core/metadata_struct'

module AudioFileUtils
  class Metadata
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def tags
      return OpenStruct.new unless AudioFileUtils::Validator.valid?(file)

      TagLib::FileRef.open(file) do |fileref|
        tags = fileref.tag || ffprobe.tags
        props = fileref.audio_properties || ffprobe.properties

        core::MetadataStruct.process!(filename: file, tags: tags, props: props)
      end
    end

    def self.tags(file)
      new(file).tags
    end

    private
    def ffprobe
      # TagLib has problems with some tags, but is about 6 times faster than Ffprobe
      # Ffprobe serves as a suitable backup when TagLib fails to read tags
      @_ffprobe ||= core::Ffprobe.new(file)
    end

    def core
      AudioFileUtils::MetadataCore
    end
  end
end
