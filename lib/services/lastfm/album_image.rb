require 'services/lastfm/image'

module Services
  module Lastfm
    class AlbumImage < Image
      private
      def destination
        File.dirname(tags.filename)
      end

      def escaped_album
        escape(tags.album)
      end

      def uri
        @_uri ||= Uri.new("album.getinfo&artist=#{escaped_artist}&album=#{escaped_album}").get
      end
    end
  end
end
