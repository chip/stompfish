require 'audio_file_utils/metadata_core/metadata_struct'
require 'audio_file_utils/metadata_core/read_tool'

module AudioFileUtils
  class Metadata
    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def tags
      metadata_struct.new(*filesystem_info, *read_tool)
    end

    def self.tags(filepath)
      new(filepath).tags
    end

    private
    def filesystem_info
      MetadataCore::FilesystemInfo.new(filepath).info
    end

    def metadata_struct
      MetadataCore::MetadataStruct
    end

    def read_tool
      MetadataCore::ReadTool.new(filepath).read
    end
  end
end
