module AudioFileUtils
  module MetadataCore
    AudioPropertiesStruct = Struct.new(:bit_rate, :duration)

    class AudioProperties
      attr_reader :properties

      def initialize(properties)
        @properties = properties
      end

      def info
        AudioPropertiesStruct.new(bit_rate, duration)
      end

      private
      def bit_rate
        properties.bitrate || properties.bit_rate.to_i
      end

      def duration
        properties.length || properties.duration.to_i
      end
    end
  end
end
