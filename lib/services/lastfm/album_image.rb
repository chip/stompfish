require 'services/lastfm/convert'
require 'services/lastfm/download'
require 'services/lastfm/uri'

module Services
  module Lastfm
    class AlbumImage
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
        @_uri ||= Uri.new("album.getinfo&artist=#{escaped_artist}&album=#{escaped_album}").get
      end

      def escaped_artist
        tags.artist.gsub("\s","+")
      end

      def escaped_album
        tags.album.gsub("\s","+")
      end

      def tags
        @_tags ||= audio_file.tags
      end

      def download_url
        uri["album"]["image"].last[lastfm_image_key]
      end

      def lastfm_image_key
        "#text"
      end
    end
  end
end
