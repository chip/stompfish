require 'services/lastfm/convert'
require 'services/lastfm/download'
require 'services/lastfm/uri'

module Services
  module Lastfm
    class ArtistImage
      attr_reader :audio_file

      def initialize(audio_file)
        @audio_file = audio_file
      end

      def download
        downloader.save and converter.convert
        converter.new_path
      end

      private
      def converter
        @_converter ||= Convert.new(downloader.location)
      end

      def downloader
        @_downloader ||= Download.new(tags: tags, url: download_url)
      end

      def uri
        @_uri ||= Uri.new("artist.getinfo&artist=#{escaped_artist}").get
      end

      def escaped_artist
        tags.artist.gsub("\s","+")
      end

      def tags
        @_tags ||= audio_file.tags
      end

      def download_url
        uri["artist"]["image"].last[lastfm_image_key]
      end

      def lastfm_image_key
        "#text"
      end
    end
  end
end
