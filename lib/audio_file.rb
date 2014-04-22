require 'catalog'
require 'audio_file_utils/metadata'
require 'audio_file_utils/move'
require 'audio_file_utils/validator'

class AudioFile
  attr_reader :filepath

  def initialize(filepath)
    @filepath = filepath
  end

  def add
    Catalog.create(tags)
  end

  def relocate(base: base)
    return unless tags.artist && tags.album
    @newpath = AudioFileUtils::Move.relocate(base: base, source: self)
  end

  def new_path
    @newpath
  end

  def tags
    @_tags ||= valid? ? AudioFileUtils::Metadata.tags(filepath) : OpenStruct.new
  end

  def valid?
    @_valid ||= AudioFileUtils::Validator.valid?(filepath)
  end
end
