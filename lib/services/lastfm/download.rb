require 'open-uri'

module Services
  module Lastfm
    class Download
      attr_reader :destination, :url

      def initialize(destination: destination, url: url)
        @destination, @url = destination, url
      end

      def location
        "#{destination}/#{download_filename}"
      end

      def save
        File.open(location, "w:ASCII-8BIT") do |f|
          f.write(url_as_file)
        end
      end

      private
      def download_filename
        File.basename(url)
      end

      def url_as_file
        open(url).read
      end
    end
  end
end
