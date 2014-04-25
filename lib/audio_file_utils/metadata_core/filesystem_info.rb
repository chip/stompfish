module AudioFileUtils
  module MetadataCore
    FilesystemInfoStruct = Struct.new(:filename, :filesize, :format)

    class FilesystemInfo
      attr_reader :filepath

      def initialize(filepath)
        @filepath = filepath
      end

      def info
        FilesystemInfoStruct.new(filepath, filesize, format)
      end

      private
      def filesize
        File.size(filepath)
      end

      def format
        File.extname(filepath)[1..-1]
      end
    end
  end
end
