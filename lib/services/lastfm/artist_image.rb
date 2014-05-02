require 'services/lastfm/image'

module Services
  module Lastfm
    class ArtistImage < Image
      private
      def uri
        @_uri ||= Uri.new("artist.getinfo&artist=#{escaped_artist}").get
      end
    end
  end
end
