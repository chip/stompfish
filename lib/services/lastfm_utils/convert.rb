require 'RMagick'

module Services
  module LastfmUtils
    class Convert
      attr_reader :source_image

      def initialize(source_image)
        @source_image = source_image
      end

      def convert
        convert_to_jpg and remove_source_image
      end

      def new_path
        "#{directory}/folder.jpg"
      end

      private
      def convert_to_jpg
        Magick::ImageList.new(source_image).write(new_path)
      end

      def directory
        File.dirname(source_image)
      end

      def remove_source_image
        FileUtils.rm_f(source_image)
      end
    end
  end
end
