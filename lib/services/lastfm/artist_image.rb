require 'services/lastfm/image'

module Services
  module Lastfm
    class ArtistImage < Image
      private
      def destination
        File.split(File.dirname(audio_file.tags.filename)).first
      end

      def uri
        @_uri ||= Uri.new("artist.getinfo&artist=#{escaped_artist}").get
      end
    end
  end
end
