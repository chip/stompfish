require 'services/lastfm/convert'
require 'services/lastfm/download'
require 'services/lastfm/uri'
require 'active_support/inflector'

module Services
  module Lastfm
    class Image
      attr_reader :audio_file

      def initialize(audio_file)
        @audio_file = audio_file
      end

      def download
        downloader.save and converter.convert
        converter.new_path
      end

      private
      def api_method
        self.class.name.demodulize.downcase.sub("image", "")
      end

      def converter
        @_converter ||= Convert.new(downloader.location)
      end

      def downloader
        @_downloader ||= Download.new(destination: destination, url: download_url)
      end

      def download_url
        uri[api_method]["image"].last[lastfm_image_key]
      end

      def escaped_artist
        escape(tags.artist)
      end

      def escape(query)
        query.gsub("\s","+")
      end

      def lastfm_image_key
        "#text"
      end

      def tags
        @_tags ||= audio_file.tags
      end
    end
  end
end
