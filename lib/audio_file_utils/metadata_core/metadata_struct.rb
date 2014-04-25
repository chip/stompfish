require 'audio_file_utils/metadata_core/audio_properties'
require 'audio_file_utils/metadata_core/filesystem_info'
require 'audio_file_utils/metadata_core/tag_attributes'

module AudioFileUtils
  module MetadataCore
    MetadataStruct = Struct.new(*FilesystemInfoStruct.members,
                                *AudioPropertiesStruct.members,
                                *TagAttributesStruct.members)
  end
end
