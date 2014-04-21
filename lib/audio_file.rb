require 'catalog'
require 'audio_file_utils/validator'
require 'audio_file_utils/metadata'

class AudioFile
  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def add
    begin
      Catalog.create(tags)
    rescue Exception => e
      ImportLog.create!(stacktrace: "#{e}", filename: tags.filename)
    end
  end

  def tags
    return OpenStruct.new unless valid?
    @_tags ||= AudioFileUtils::Metadata.tags(filepath)
  end

  def valid?
    @_valid ||= AudioFileUtils::Validator.valid?(filepath)
  end
end
