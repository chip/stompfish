require 'open-uri'

module Services
  module Lastfm
    class Download
      attr_reader :tags, :url

      def initialize(tags: tags, url: url)
        @tags, @url = tags, url
      end

      def location
        "#{download_directory}/#{download_filename}"
      end

      def save
        File.open(location, "w:ASCII-8BIT") do |f|
          f.write(url_as_file)
        end
      end

      private
      def download_directory
        File.dirname(tags.filename)
      end

      def download_filename
        File.basename(url)
      end

      def url_as_file
        open(url).read
      end
    end
  end
end
